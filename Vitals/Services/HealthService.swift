//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import FactoryKit
import HealthKit

// MARK: - Protocol

protocol HealthServiceProtocol: AnyObject {
    
    // MARK: - Properties
    
    var healthStore: HKHealthStore { get }

    // MARK: - Methods

    func isAvailable() -> Bool

}

// MARK: - Implementation

final class HealthService: HealthServiceProtocol {
    
    // MARK: - Properties
    
    let healthStore: HKHealthStore = .init()
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    func isAvailable() -> Bool {
        HKHealthStore.isHealthDataAvailable() ? true : false
    }

}

// MARK: - Factory

extension Container {

    var healthService: Factory<HealthServiceProtocol> {
        self { @MainActor in HealthService() }
            .singleton
    }

}
