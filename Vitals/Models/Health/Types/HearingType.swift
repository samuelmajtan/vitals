//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum HearingType: CaseIterable, MeasurementType {

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

    var identifier: HealthTypeIdentifier {
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

}

extension HearingType: Identifiable {

    var id: Self {
        self
    }

}
