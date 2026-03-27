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

}

extension SampleStatisticsOptions: Identifiable {

    var id: Self {
        self
    }

}
