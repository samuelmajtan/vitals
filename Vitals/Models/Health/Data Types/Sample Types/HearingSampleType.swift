//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum HearingSampleType: CaseIterable, SampleTypeProtocol {

    case environmentalAudioExposure
    case headphoneAudioExposure
    case environmentalAudioExposureEvent
    case headphoneAudioExposureEvent

    var title: String {
        switch self {
        case .environmentalAudioExposure:
            "Environmental Audio Exposure"
        case .headphoneAudioExposure:
            "Headphone Audio Exposure"
        case .environmentalAudioExposureEvent:
            "Environmental Audio Exposure Event"
        case .headphoneAudioExposureEvent:
            "Headphone Audio Exposure Event"
        }
    }

    var type: SampleType {
        switch self {
        case .environmentalAudioExposure:
                .quantity(.environmentalAudioExposure)
        case .headphoneAudioExposure:
                .quantity(.headphoneAudioExposure)
        case .environmentalAudioExposureEvent:
                .category(.environmentalAudioExposureEvent)
        case .headphoneAudioExposureEvent:
                .category(.headphoneAudioExposureEvent)
        }
    }
    
    var category: SampleCategory {
        .hearing
    }
    
}

extension HearingSampleType {
    
    var config: SampleConfiguration {
        switch self {
        case .environmentalAudioExposure:
            return .init(.discreteAverage, chartStyle: .bar, summaryLabel: .average, dateInterval: Date.dailyInterval)
        case .headphoneAudioExposure:
            return .init(.discreteAverage, chartStyle: .bar, summaryLabel: .average, dateInterval: Date.dailyInterval)
        case .environmentalAudioExposureEvent:
            return .init(.mostRecent, chartStyle: .bar, summaryLabel: .latest, dateInterval: Date.weeklyInterval)
        case .headphoneAudioExposureEvent:
            return .init(.mostRecent, chartStyle: .bar, summaryLabel: .latest, dateInterval: Date.weeklyInterval)
        }
    }
    
}

extension HearingSampleType: Identifiable {

    var id: Self {
        self
    }

}
