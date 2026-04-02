//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum SleepSampleType: CaseIterable, SampleTypeProtocol {

    case mindfulSession
    case sleepAnalysis
    case appleSleepingWristTemperature

    var title: String {
        switch self {
        case .mindfulSession:
            "Mindful Session"
        case .sleepAnalysis:
            "Sleep Analysis"
        case .appleSleepingWristTemperature:
            "Apple Sleeping Wrist Temperature"
        }
    }

    var type: SampleType {
        switch self {
        case .mindfulSession:
                .category(.mindfulSession)
        case .sleepAnalysis:
                .category(.sleepAnalysis)
        case .appleSleepingWristTemperature:
                .quantity(.appleSleepingWristTemperature)
        }
    }

    var category: SampleCategory {
        .sleep
    }

}

extension SleepSampleType {
    
    var config: SampleConfiguration {
        switch self {
        case .sleepAnalysis:
            return .init(.duration, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.weeklyInterval)
        case .mindfulSession:
            return .init(.duration, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.weeklyInterval)
        case .appleSleepingWristTemperature:
            return .init(.discreteAverage, chartStyle: .interpolatedLine, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        }
    }
    
}
    
extension SleepSampleType: Identifiable {

    var id: Self {
        self
    }

}
