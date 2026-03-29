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

    // MARK: - Methods

    func fetchStatistics(
        type: HKQuantityTypeIdentifier,
        interval: DateInterval,
        options: HKStatisticsOptions
    ) async throws -> HKStatistics?
   
   func fetchStatisticsCollection(
        type: HKQuantityTypeIdentifier,
        interval: DateInterval,
        options: HKStatisticsOptions,
        intervalComponents: DateComponents
    ) async throws -> HKStatisticsCollection
  
    func fetchQuantitySamples(
        type: HKQuantityTypeIdentifier,
        interval: DateInterval,
        limit: Int?
    ) async throws -> [HKQuantitySample]
   
    func fetchCategorySamples(
        type: HKCategoryTypeIdentifier,
        interval: DateInterval
    ) async throws -> [HKCategorySample]

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

    func fetchStatistics(
        type: HKQuantityTypeIdentifier,
        interval: DateInterval,
        options: HKStatisticsOptions
    ) async throws -> HKStatistics? {
        let predicate = HKQuery.predicateForSamples(withStart: interval.start, end: interval.end)
        let descriptor = HKStatisticsQueryDescriptor(
            predicate: .quantitySample(type: HKQuantityType(type), predicate: predicate),
            options: options
        )
        return try await descriptor.result(for: healthStore)
    }

    func fetchStatisticsCollection(
        type: HKQuantityTypeIdentifier,
        interval: DateInterval,
        options: HKStatisticsOptions,
        intervalComponents: DateComponents
    ) async throws -> HKStatisticsCollection {
        let predicate = HKQuery.predicateForSamples(withStart: interval.start, end: interval.end)
        let descriptor = HKStatisticsCollectionQueryDescriptor(
            predicate: .quantitySample(type: HKQuantityType(type), predicate: predicate),
            options: options,
            anchorDate: interval.start,
            intervalComponents: intervalComponents
        )
        return try await descriptor.result(for: healthStore)
    }

    func fetchQuantitySamples(
        type: HKQuantityTypeIdentifier,
        interval: DateInterval,
        limit: Int? = nil
    ) async throws -> [HKQuantitySample] {
        let predicate = HKQuery.predicateForSamples(withStart: interval.start, end: interval.end)
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.quantitySample(type: HKQuantityType(type), predicate: predicate)],
            sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)],
            limit: limit
        )
        return try await descriptor.result(for: healthStore)
    }

    func fetchCategorySamples(
        type: HKCategoryTypeIdentifier,
        interval: DateInterval
    ) async throws -> [HKCategorySample] {
        let predicate = HKQuery.predicateForSamples(withStart: interval.start, end: interval.end)
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.categorySample(type: HKCategoryType(type), predicate: predicate)],
            sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)],
            limit: nil
        )
        return try await descriptor.result(for: healthStore)
    }

}

// MARK: - Factory

extension Container {

    var measurementProvider: Factory<MeasurementProviderProtocol> {
        self { MeasurementProvider(self.healthStore()) }
            .singleton
    }

}
