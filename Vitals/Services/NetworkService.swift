//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import FactoryKit

// MARK: - Protocol

protocol NetworkServiceProtocol: AnyObject {

    // MARK: - Properties

    // MARK: - Methods

    func sendMeasurements(request: MeasurementsRequest) -> AsyncStream<FetchState<MeasurementsResponse>>

}

// MARK: - Implementation

final class NetworkingService: NetworkServiceProtocol {

    // MARK: - Properties

    private let session : URLSession
    private let cache: NetworkCacheServiceProtocol

    // MARK: - Lifecycle

    init(
        session: URLSession = URLSession(configuration: .default),
        cache: NetworkCacheServiceProtocol
    ) {
        self.session = session
        self.cache = cache
    }

}

// MARK: - Public Methods

extension NetworkingService {

    func sendMeasurements(request: MeasurementsRequest) -> AsyncStream<FetchState<MeasurementsResponse>> {
        return requestStream(.sendMeasurements(request))
    }

}

// MARK: - Private Methods

private extension NetworkingService {
    
    func requestStream<T>(_ endpoint: Endpoint) -> AsyncStream<FetchState<T>> where T: Decodable & Sendable {
        AsyncStream { continuation in
            continuation.yield(.loading)
            
            Task {
                let result: Result<T, AppError> = await self.request(endpoint: endpoint)
                continuation.yield(result.asFetchState())
                continuation.finish()
            }
        }
    }
    
    func request<T>(endpoint: Endpoint) async -> Result<T, AppError> where T: Decodable & Sendable {
        guard var url = URL(string: APIServer.base.rawValue) else {
            return .failure(.network(.invalidURL))
        }
        url.appendPathComponent(endpoint.path)
        
        let urlRequest: URLRequest
        do {
            urlRequest = try await buildRequest(url: url, endpoint: endpoint)
        } catch {
            return .failure(error)
        }
        
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(for: urlRequest)
        } catch {
            return .failure(.network(.badRequest))
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(.network(.badRequest))
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            break
        case 400..<500:
            return .failure(.network(.httpError(httpResponse.statusCode)))
        default:
            return .failure(.network(.httpError(httpResponse.statusCode)))
        }

        do {
            let decoded: T = try decodeData(data)
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }

    func buildRequest(url: URL, endpoint: Endpoint) async throws(AppError) -> URLRequest {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)

        let queryItems = endpoint.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        if !queryItems.isEmpty {
            urlComponents?.queryItems = queryItems
        }

        guard let resolvedURL = urlComponents?.url else { throw .network(.invalidURL) }

        var request = URLRequest(url: resolvedURL)
        request.httpMethod = endpoint.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if endpoint.isAuthorized {
            let token = await cache.get(.loginResponse) as LoginResponse?
            if let token = token?.token, !token.isEmpty {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }

        if let model = endpoint.model {
            do {
                request.httpBody = try JSONEncoder().encode(model)
            } catch {
                throw .parsing(error.localizedDescription)
            }
        }

        return request
    }

    func decodeData<T>(_ data: Data) throws(AppError) -> T where T: Decodable & Sendable {
        if T.self == EmptyResponse.self, let response = EmptyResponse() as? T {
            return response
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw .parsing(error.localizedDescription)
        }
    }

}

// MARK: - Factory

extension Container {

    var networkingService: Factory<NetworkServiceProtocol> {
        self { NetworkingService(cache: self.networkCacheService()) }
            .singleton
    }

}

