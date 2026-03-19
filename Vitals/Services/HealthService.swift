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
    
}

// MARK: - Implementation

final class HealthService: HealthServiceProtocol {
    
    
    func foo() {
    }

}

// MARK: - Factory

extension Container {

    var healthService: Factory<HealthServiceProtocol> {
        self { @MainActor in HealthService() }
            .singleton
    }

}
