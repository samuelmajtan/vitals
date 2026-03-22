//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import FactoryKit
import HealthKit

// MARK: - Protocol

protocol MedicationProviderProtocol: AnyObject {
    
    // MARK: - Properties
    
    // MARK: - Methods
    
}

// MARK: - Implementation

final actor MedicationProvider: MedicationProviderProtocol {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
}

// MARK: - Factory

extension Container {
    
    var medicationProvider: Factory<MedicationProviderProtocol> {
        self { @MainActor in MedicationProvider() }
            .singleton
    }
    
}
