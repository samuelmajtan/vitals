//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI
import HealthKit

enum SampleCategory: CaseIterable, Equatable, Hashable {
    
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
    var types: [AnySampleType] {
        switch self {
        case .activity:
            ActivitySampleType.allCases.map(AnySampleType.init)
        case .bodyMeasurements:
            BodyMeasurementsSampleType.allCases.map(AnySampleType.init)
        case .hearing:
            HearingSampleType.allCases.map(AnySampleType.init)
        case .mobility:
            MobilitySampleType.allCases.map(AnySampleType.init)
        case .nutrition:
            NutritionSampleType.allCases.map(AnySampleType.init)
        case .sleep:
            SleepSampleType.allCases.map(AnySampleType.init)
        case .symptoms:
            SymptomSampleType.allCases.map(AnySampleType.init)
        case .vitals:
            VitalsSampleType.allCases.map(AnySampleType.init)
        }
    }
    
}

extension SampleCategory: Identifiable {
    
    var id: Self {
        self
    }

}
