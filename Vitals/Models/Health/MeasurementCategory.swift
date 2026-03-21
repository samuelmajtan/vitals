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
            "flame"
        case .bodyMeasurements:
            "figure"
        case .hearing:
            "ear"
        case .mobility:
            "figure.walk"
        case .nutrition:
            "carrot"
        case .sleep:
            "bed.double"
        case .symptoms:
            "allergens"
        case .vitals:
            "waveform.path.ecg.rectangle"
        }
    }
    
    var color: Color {
        switch self {
        case .activity:
                .orange
        case .bodyMeasurements:
                .teal
        case .hearing:
                .pink
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
    
    var types: [any MeasurementType] {
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
