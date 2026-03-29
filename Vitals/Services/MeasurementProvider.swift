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
    
    func fetchQuantitySamples(type: HKQuantityTypeIdentifier, interval: DateInterval, limit: Int?) async throws -> [HKQuantitySample]
    func fetchStatistics(type: HKQuantityTypeIdentifier, interval: DateInterval, options: HKStatisticsOptions) async throws -> HKStatistics?
    func fetchStatisticsCollection(type: HKQuantityTypeIdentifier, interval: DateInterval, options: HKStatisticsOptions, intervalComponents: DateComponents) async throws -> HKStatisticsCollection
    func fetchCategorySamples(type: HKCategoryTypeIdentifier, interval: DateInterval) async throws -> [HKCategorySample]

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
    
    // MARK: - Quantity Sample
    
    func fetchQuantitySamples(
        type: HKQuantityTypeIdentifier,
        interval: DateInterval,
        limit: Int? = 10
    ) async throws -> [HKQuantitySample] {
        let quantityType = HKQuantityType(type)
        
        let predicate = HKQuery.predicateForSamples(
            withStart: interval.start,
            end: interval.end
        )
        
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.quantitySample(type: quantityType, predicate: predicate)],
            sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)],
            limit: limit
        )
        
        return try await descriptor.result(for: healthStore)
    }
    
    // MARK: - Statistics
    
    func fetchStatistics(
        type: HKQuantityTypeIdentifier,
        interval: DateInterval,
        options: HKStatisticsOptions
    ) async throws -> HKStatistics? {
        let quantityType = HKQuantityType(type)

        let predicate = HKQuery.predicateForSamples(
            withStart: interval.start,
            end: interval.end
        )

        let descriptor = HKStatisticsQueryDescriptor(
            predicate: .quantitySample(type: quantityType, predicate: predicate),
            options: options
        )

        return try await descriptor.result(for: healthStore)
    }
    
    // MARK: - Statistics Collection
    
    func fetchStatisticsCollection(
        type: HKQuantityTypeIdentifier,
        interval: DateInterval,
        options: HKStatisticsOptions,
        intervalComponents: DateComponents
    ) async throws -> HKStatisticsCollection {
        let quantityType = HKQuantityType(type)
        
        let predicate = HKQuery.predicateForSamples(
            withStart: interval.start,
            end: interval.end
        )
        
        let descriptor = HKStatisticsCollectionQueryDescriptor(
            predicate: .quantitySample(type: quantityType, predicate: predicate),
            options: options,
            anchorDate: interval.start,
            intervalComponents: intervalComponents
        )
        
        return try await descriptor.result(for: healthStore)
    }
    
    // MARK: - Category Sample
    
    func fetchCategorySamples(
        type: HKCategoryTypeIdentifier,
        interval: DateInterval
    ) async throws -> [HKCategorySample] {
        let categoryType = HKCategoryType(type)
        
        let predicate = HKQuery.predicateForSamples(
            withStart: interval.start,
            end: interval.end
        )
        
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.categorySample(type: categoryType, predicate: predicate)],
            sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)],
            limit: nil
        )
        
        return try await descriptor.result(for: healthStore)
    }

}

// MARK: - Factory

extension Container {

    var measurementProvider: Factory<MeasurementProviderProtocol> {
        self { @MainActor in MeasurementProvider(self.healthService().healthStore) }
            .singleton
    }

}
