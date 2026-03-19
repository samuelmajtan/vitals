//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum BodyMeasurementsType: CaseIterable, MeasurementType {

    case height
    case bodyMass
    case bodyMassIndex
    case leanBodyMass
    case bodyFatPercentage
    case waistCircumference

    var title: String {
        switch self {
        case .height:               
            "Height"
        case .bodyMass:             
            "Body Mass"
        case .bodyMassIndex:        
            "Body Mass Index"
        case .leanBodyMass:         
            "Lean Body Mass"
        case .bodyFatPercentage:    
            "Body Fat Percentage"
        case .waistCircumference:   
            "Waist Circumference"
        }
    }

    var identifier: HealthTypeIdentifier {
        switch self {
        case .height:
                .quantity(.height)
        case .bodyMass:
                .quantity(.bodyMass)
        case .bodyMassIndex:
                .quantity(.bodyMassIndex)
        case .leanBodyMass:
                .quantity(.leanBodyMass)
        case .bodyFatPercentage:
                .quantity(.bodyFatPercentage)
        case .waistCircumference:
                .quantity(.waistCircumference)
        }
    }

}

extension BodyMeasurementsType: Identifiable {

    var id: Self {
        self
    }

}
