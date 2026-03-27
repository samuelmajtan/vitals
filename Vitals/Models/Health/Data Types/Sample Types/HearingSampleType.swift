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
    
    var config: SampleConfiguration {
        switch self {
            
        case .environmentalAudioExposure, .headphoneAudioExposure:
            return .init(.discreteAverage, chart: .bar, dateInterval: Date.dailyInterval)
        case .environmentalAudioExposureEvent, .headphoneAudioExposureEvent:
            return .init(.mostRecent, chart: .bar, dateInterval: Date.weeklyInterval)
        }
    }

}

extension HearingSampleType: Identifiable {

    var id: Self {
        self
    }

}
