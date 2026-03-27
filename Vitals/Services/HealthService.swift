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
    var readTypes: Set<HKSampleType> { get }

    // MARK: - Methods

    func isAvailable() -> Bool
    func fetchSampleStatistics(for type: AnySampleType) async throws -> Sample?
    
}

// MARK: - Implementation

final class HealthService: HealthServiceProtocol {

    // MARK: - Properties
    
    let healthStore: HKHealthStore = .init()
    let readTypes: Set<HKSampleType> = Set(
        SampleCategory.allCases
            .flatMap(\.types)
            .map(\.type.sampleType)
    )
    
    // MARK: - Lifecycle

    // MARK: - Methods

    func isAvailable() -> Bool {
        HKHealthStore.isHealthDataAvailable() ? true : false
    }
   
    func fetchSampleStatistics(for type: AnySampleType) async throws -> Sample? {
        let dateInterval = type.config.dateInterval
        let statistics = type.config.statistics
        
        let predicate = HKQuery.predicateForSamples(withStart: dateInterval.start, end: dateInterval.end)
        
        guard let quantityType = type.type.sampleType as? HKQuantityType else {
            return nil
        }
        let quantityTypeIdentifier = HKQuantityTypeIdentifier(rawValue: type.type.sampleType.identifier)

        let samplePredicate = HKSamplePredicate.quantitySample(
            type: quantityType,
            predicate: predicate
        )
        
        let descriptor = HKStatisticsQueryDescriptor(
            predicate: samplePredicate,
            options: statistics.value
        )
        
        guard let result = try await descriptor.result(for: healthStore) else {
            return nil
        }

        return switch statistics {
        case .discreteAverage:
            Sample(type, date: result.endDate, value: result.averageQuantity()?.doubleValue(for: quantityTypeIdentifier.defaultUnit) ?? 0, unit: quantityTypeIdentifier.displayUnit)
        case .discreteMin:
            Sample(type, date: result.endDate, value: result.minimumQuantity()?.doubleValue(for: quantityTypeIdentifier.defaultUnit) ?? 0, unit: quantityTypeIdentifier.displayUnit)
        case .discreteMax:
            Sample(type, date: result.endDate, value: result.maximumQuantity()?.doubleValue(for: quantityTypeIdentifier.defaultUnit) ?? 0, unit: quantityTypeIdentifier.displayUnit)
        case .cumulativeSum:
            Sample(type, date: result.endDate, value: result.sumQuantity()?.doubleValue(for: quantityTypeIdentifier.defaultUnit) ?? 0, unit: quantityTypeIdentifier.displayUnit)
        case .mostRecent:
            Sample(type, date: result.endDate, value: result.mostRecentQuantity()?.doubleValue(for: quantityTypeIdentifier.defaultUnit) ?? 0, unit: quantityTypeIdentifier.displayUnit)
        case .duration:
            Sample(type, date: result.endDate, value: result.duration()?.doubleValue(for: quantityTypeIdentifier.defaultUnit) ?? 0, unit: quantityTypeIdentifier.displayUnit)
        default:
            Sample(type, date: result.endDate, value: result.averageQuantity()?.doubleValue(for: quantityTypeIdentifier.defaultUnit) ?? 0, unit: quantityTypeIdentifier.displayUnit)
        }
    }
    
}

// MARK: - Factory

extension Container {
    
    var healthService: Factory<HealthServiceProtocol> {
        self { @MainActor in HealthService() }
            .singleton
    }
    
}
