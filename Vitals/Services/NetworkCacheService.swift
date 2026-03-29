//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import FactoryKit
import Defaults

// MARK: - Protocol

protocol NetworkCacheServiceProtocol: AnyObject {

    // MARK: - Properties

    // MARK: - Methods

    func get<T>(_ key: CacheKey) async -> T? where T: Decodable & Sendable
    func set<T>(_ key: CacheKey, value: T) async where T: Encodable & Sendable
    func remove(_ key: CacheKey) async
    func clearAll() async

}

// MARK: - Implementation

final actor NetworkCacheService: NetworkCacheServiceProtocol {

    // MARK: - Properties

    private var cache: [CacheKey: Data] = [:]

    // MARK: - Lifecycle

    init() { }

    // MARK: - Methods

    func get<T>(_ key: CacheKey) -> T? where T: Decodable & Sendable {
        guard let data = cache[key] else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func set<T>(_ key: CacheKey, value: T) where T: Encodable & Sendable {
        cache[key] = try? JSONEncoder().encode(value)
    }

    func remove(_ key: CacheKey) {
        cache.removeValue(forKey: key)
    }

    func clearAll() {
        cache.removeAll()
    }

}

// MARK: - Factory

extension Container {

    var networkCacheService: Factory<NetworkCacheServiceProtocol> {
        self { NetworkCacheService() }
            .singleton
    }

}
