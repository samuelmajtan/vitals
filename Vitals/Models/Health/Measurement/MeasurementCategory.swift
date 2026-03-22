//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI

enum MeasurementCategory: CaseIterable, Equatable, Hashable {
    
    case activity
    case bodyMeasurements
    case hearing
    case mobility
    case nutrition
    case sleep
    case symptoms
    case vitals
    
    var title: String {
        switch self {
        case .activity:
            "Activity"
        case .bodyMeasurements:
            "Body Measurements"
        case .hearing:
            "Hearing"
        case .mobility:
            "Mobility"
        case .nutrition:
            "Nutrition"
        case .sleep:
            "Sleep"
        case .symptoms:
            "Symptoms"
        case .vitals:
            "Vitals"
        }
    }
    
    var image: String {
        switch self {
        case .activity:
            SF.activity.rawValue
        case .bodyMeasurements:
            SF.bodyMeasurements.rawValue
        case .hearing:
            SF.hearing.rawValue
        case .mobility:
            SF.mobility.rawValue
        case .nutrition:
            SF.nutrition.rawValue
        case .sleep:
            SF.sleep.rawValue
        case .symptoms:
            SF.symptoms.rawValue
        case .vitals:
            SF.vitals.rawValue
        }
    }
    
    var color: Color {
        switch self {
        case .activity:
                .orange
        case .bodyMeasurements:
                .brown
        case .hearing:
                .yellow
        case .mobility:
                .blue
        case .nutrition:
                .green
        case .sleep:
                .indigo
        case .symptoms:
                .indigo
        case .vitals:
                .teal
        }
    }
    
    var types: [any MeasurementTypeProtocol] {
        switch self {
        case .activity:
            ActivityType.allCases
        case .bodyMeasurements:
            BodyMeasurementsType.allCases
        case .hearing:
            HearingType.allCases
        case .mobility:
            MobilityType.allCases
        case .nutrition:
            NutritionType.allCases
        case .sleep:
            SleepType.allCases
        case .symptoms:
            SymptomType.allCases
        case .vitals:
            VitalsType.allCases
        }
    }
    
}

extension MeasurementCategory: Identifiable {
    
    var id: Self {
        self
    }

}
