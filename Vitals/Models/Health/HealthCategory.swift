//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI

enum HealthCategory: CaseIterable, Equatable, Hashable {
    
    case activity
    case bodyMeasurements
    case cycleTracking
    case hearing
    case heart
    case mentalWellbeing
    case mobility
    case nutrition
    case respiratory
    case sleep
    case symptoms
    case vitals
    case otherData
    
    var title: String {
        switch self {
        case .activity:
            "Activity"
        case .bodyMeasurements:
            "Body Measurements"
        case .cycleTracking:
            "Cycle Tracking"
        case .hearing:
            "Hearing"
        case .heart:
            "Heart"
        case .mentalWellbeing:
            "Mental Wellbeing"
        case .mobility:
            "Mobility"
        case .nutrition:
            "Nutrition"
        case .respiratory:
            "Respiratory"
        case .sleep:
            "Sleep"
        case .symptoms:
            "Symptoms"
        case .vitals:
            "Vitals"
        case .otherData:
            "Other Data"
        }
    }
    
    var image: String {
        switch self {
        case .activity:
            "flame"
        case .bodyMeasurements:
            "figure"
        case .cycleTracking:
            "calendar"
        case .hearing:
            "ear"
        case .heart:
            "heart.fill"
        case .mentalWellbeing:
            "brain.head.profile"
        case .mobility:
            "figure.walk"
        case .nutrition:
            "carrot"
        case .respiratory:
            "lungs"
        case .sleep:
            "bed.double"
        case .symptoms:
            "allergens"
        case .vitals:
            "waveform.path.ecg.rectangle"
        case .otherData:
            "plus.square.dashed"
        }
    }
    
    var color: Color {
        switch self {
        case .activity:
                .orange
        case .bodyMeasurements:
                .teal
        case .cycleTracking:
                .pink
        case .hearing:
                .pink
        case .heart:
                .red
        case .mentalWellbeing:
                .green
        case .mobility:
                .blue
        case .nutrition:
                .green
        case .respiratory:
                .cyan
        case .sleep:
                .indigo
        case .symptoms:
                .indigo
        case .vitals:
                .teal
        case .otherData:
                .gray
        }
    }
    
}

extension HealthCategory: Identifiable {
    
    var id: Self {
        self
    }

}
