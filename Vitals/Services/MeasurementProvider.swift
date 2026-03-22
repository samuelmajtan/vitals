//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import FactoryKit
import HealthKit

// MARK: - Protocol

protocol MeasurementProviderProtocol: AnyObject {
    
    // MARK: - Properties
    
    // MARK: - Methods
    
}

// MARK: - Implementation

final actor MeasurementProvider: MeasurementProviderProtocol {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
}

// MARK: - Factory

extension Container {

    var measurementProvider: Factory<MeasurementProviderProtocol> {
        self { @MainActor in MeasurementProvider() }
            .singleton
    }

}
