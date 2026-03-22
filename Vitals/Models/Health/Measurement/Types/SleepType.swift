//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum SleepType: CaseIterable, MeasurementTypeProtocol {

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

    var type: MeasurementType {
        switch self {
        case .mindfulSession:
                .category(.mindfulSession)
        case .sleepAnalysis:
                .category(.sleepAnalysis)
        case .appleSleepingWristTemperature:
                .quantity(.appleSleepingWristTemperature)
        }
    }

}
    
extension SleepType: Identifiable {

    var id: Self {
        self
    }

}
