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

    var readTypes: Set<HKSampleType> { get }

    // MARK: - Methods

    func isAvailable() -> Bool
    func fetchSample(for type: AnySampleType) async throws -> Sample?
    func fetchSampleData(for type: AnySampleType, in interval: DateInterval, limit: Int?) async throws -> [SampleData]

}

// MARK: - Implementation

final class HealthService: HealthServiceProtocol {

    // MARK: - Services

    @Injected(\.measurementProvider)
    private var measurementProvider: MeasurementProviderProtocol

    // MARK: - Properties

    let readTypes: Set<HKSampleType> = Set(
        SampleCategory.allCases
            .flatMap(\.types)
            .map(\.type.sampleType)
    )

    // MARK: - Methods

    func isAvailable() -> Bool {
        HKHealthStore.isHealthDataAvailable()
    }

    func fetchSample(for type: AnySampleType) async throws -> Sample? {
        for interval in SampleInterval.allCases {
            if let sample = try await fetchStatistics(for: type, in: interval.dateInterval, assignedTo: interval) {
                return sample
            }
        }
        return nil
    }

    func fetchSampleData(
        for type: AnySampleType,
        in interval: DateInterval,
        limit: Int? = nil
    ) async throws -> [SampleData] {
        switch type.type {
        case .quantity(let identifier):
            return try await measurementProvider
                .fetchQuantitySamples(type: identifier, interval: interval, limit: limit)
                .map { SampleData(date: $0.endDate, value: $0.quantity.doubleValue(for: identifier.defaultUnit)) }
        default:
            return []
        }
    }

}

// MARK: - Private

private extension HealthService {

    func fetchStatistics(
        for type: AnySampleType,
        in interval: DateInterval,
        assignedTo sampleInterval: SampleInterval
    ) async throws -> Sample? {
        switch type.type {
        case .quantity(let identifier):
            return try await fetchQuantitySample(
                type: type,
                identifier: identifier,
                interval: interval,
                sampleInterval: sampleInterval
            )
        case .category(let identifier):
            return try await fetchCategorySample(
                type: type,
                identifier: identifier,
                interval: interval,
                sampleInterval: sampleInterval
            )
        default:
            return nil
        }
    }

    func fetchQuantitySample(
        type: AnySampleType,
        identifier: HKQuantityTypeIdentifier,
        interval: DateInterval,
        sampleInterval: SampleInterval
    ) async throws -> Sample? {
        guard let statistics = try await measurementProvider.fetchStatistics(
            type: identifier,
            interval: interval,
            options: type.config.statistics.value
        ) else { return nil }
        
        guard let value = type.config.statistics.extractValue(from: statistics, unit: identifier.defaultUnit),
              value > 0 else { return nil }
        
        return Sample(type, date: statistics.endDate, value: value, unit: identifier.displayUnit, interval: sampleInterval)
    }

    func fetchCategorySample(
        type: AnySampleType,
        identifier: HKCategoryTypeIdentifier,
        interval: DateInterval,
        sampleInterval: SampleInterval
    ) async throws -> Sample? {
        let samples = try await measurementProvider.fetchCategorySamples(type: identifier, interval: interval)
        guard !samples.isEmpty else { return nil }
        
        let totalHours = samples.reduce(0.0) {
            $0 + $1.endDate.timeIntervalSince($1.startDate)
        } / 3600
        
        guard totalHours > 0 else { return nil }
        
        return Sample(type, date: samples[0].endDate, value: totalHours, unit: "h", interval: sampleInterval)
    }

}

// MARK: - Factory

extension Container {

    var healthService: Factory<HealthServiceProtocol> {
        self { HealthService() }
            .singleton
    }

    var healthStore: Factory<HKHealthStore> {
        self { HKHealthStore() }
            .singleton
    }

}
