//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI
import HealthKit

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
    
    @MainActor
    var types: [AnyMeasurementType] {
        switch self {
        case .activity:
            ActivityType.allCases.map(AnyMeasurementType.init)
        case .bodyMeasurements:
            BodyMeasurementsType.allCases.map(AnyMeasurementType.init)
        case .hearing:
            HearingType.allCases.map(AnyMeasurementType.init)
        case .mobility:
            MobilityType.allCases.map(AnyMeasurementType.init)
        case .nutrition:
            NutritionType.allCases.map(AnyMeasurementType.init)
        case .sleep:
            SleepType.allCases.map(AnyMeasurementType.init)
        case .symptoms:
            SymptomType.allCases.map(AnyMeasurementType.init)
        case .vitals:
            VitalsType.allCases.map(AnyMeasurementType.init)
        }
    }
    
}

extension MeasurementCategory: Identifiable {
    
    var id: Self {
        self
    }

}
