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
    
    func fetchSamples(for type: HKSampleType, with limit: Int) async throws

}

// MARK: - Implementation

final actor MeasurementProvider: MeasurementProviderProtocol {

    // MARK: - Properties

    private let healthStore: HKHealthStore
    
    // MARK: - Lifecycle

    init(_ healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    // MARK: - Methods

    func fetchSamples(for type: HKSampleType, with limit: Int = 10) async throws {
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.sample(type: type)],
            sortDescriptors: [SortDescriptor(\.endDate, order: .reverse)],
            limit: limit
        )
        
        let results = try await descriptor.result(for: healthStore)
    }

}

// MARK: - Factory

extension Container {

    var measurementProvider: Factory<MeasurementProviderProtocol> {
        self { @MainActor in MeasurementProvider(self.healthService().healthStore) }
            .singleton
    }

}
