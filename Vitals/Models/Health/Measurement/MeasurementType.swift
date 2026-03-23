//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

protocol MeasurementTypeProtocol: Equatable, Hashable, Identifiable {
    
    var title: String { get }
    var type: MeasurementType { get }
    
}

enum MeasurementType: Equatable, Hashable {

    case quantity(HKQuantityTypeIdentifier)
    case category(HKCategoryTypeIdentifier)
    case correlation(HKCorrelationTypeIdentifier)
    case heartbeatSeries
    case electrocardiogram
    
    var sampleType: HKSampleType? {
        switch self {
        case .quantity(let id):
            HKQuantityType(id)
        case .category(let id):
            HKCategoryType(id)
        case .correlation(let id):
            HKCorrelationType(id)
        case .heartbeatSeries:
            HKSeriesType.heartbeat()
        case .electrocardiogram:
            HKSampleType.electrocardiogramType()
        }
    }

}
