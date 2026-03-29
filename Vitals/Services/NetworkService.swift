//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import FactoryKit

// MARK: - Protocol

protocol NetworkingProtocol: AnyObject {

    // MARK: - Properties

    // MARK: - Methods

}

// MARK: - Implementation

final class NetworkingService: NetworkingProtocol {
    
    // MARK: - Properties
    
    private let session : URLSession
    
    // MARK: - Initializer
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
}

// MARK: - Public Methods

extension NetworkingService {
    
}

// MARK: - Private Methods

private extension NetworkingService {

}

// MARK: - Factory

extension Container {

    var networkingService: Factory<NetworkingProtocol> {
        self { @MainActor in NetworkingService() }
            .singleton
    }

}

