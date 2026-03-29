//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum SampleStatisticsOptions {

    case seperateBySource
    case discreteAverage
    case discreteMin
    case discreteMax
    case cumulativeSum
    case mostRecent
    case duration

    var value: HKStatisticsOptions {
        switch self {
        case .seperateBySource:
                .separateBySource
        case .discreteAverage:
                .discreteAverage
        case .discreteMin:
                .discreteMin
        case .discreteMax:
                .discreteMax
        case .cumulativeSum:
                .cumulativeSum
        case .mostRecent:
                .mostRecent
        case .duration:
                .duration
        }
    }

    func extractValue(from statistics: HKStatistics, unit: HKUnit) -> Double? {
        switch self {
        case .mostRecent:
            return statistics.mostRecentQuantity()?.doubleValue(for: unit)
        case .discreteMin:
            return statistics.minimumQuantity()?.doubleValue(for: unit)
        case .discreteMax:
            return statistics.maximumQuantity()?.doubleValue(for: unit)
        case .cumulativeSum:
            return statistics.sumQuantity()?.doubleValue(for: unit)
        case .duration:
            return statistics.duration()?.doubleValue(for: .second())
        default:
            return statistics.averageQuantity()?.doubleValue(for: unit)
        }
    }

}

extension SampleStatisticsOptions: Identifiable {

    var id: Self {
        self
    }

}
