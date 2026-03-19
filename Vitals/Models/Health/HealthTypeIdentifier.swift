//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum HealthTypeIdentifier {

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
            HKObjectType.correlationType(forIdentifier: id)
        case .heartbeatSeries:
            HKSeriesType.heartbeat()
        case .electrocardiogram:
            HKObjectType.electrocardiogramType()
        }
    }

}
