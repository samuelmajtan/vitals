//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum VitalsType: CaseIterable, MeasurementType {

    case heartRate
    case lowHeartRateEvent
    case highHeartRateEvent
    case irregularHeartRhythmEvent
    case restingHeartRate
    case heartRateVariabilitySDNN
    case heartRateRecoveryOneMinute
    case atrialFibrillationBurden
    case walkingHeartRateAverage
    case heartbeatSeries
    case electrocardiogram
    case oxygenSaturation
    case bodyTemperature
    case bloodPressure
    case bloodPressureSystolic
    case bloodPressureDiastolic
    case respiratoryRate

    var title: String {
        switch self {
        case .heartRate:                    
            "Heart Rate"
        case .lowHeartRateEvent:            
            "Low Heart Rate Event"
        case .highHeartRateEvent:           
            "High Heart Rate Event"
        case .irregularHeartRhythmEvent:    
            "Irregular Heart Rhythm Event"
        case .restingHeartRate:             
            "Resting Heart Rate"
        case .heartRateVariabilitySDNN:     
            "Heart Rate Variability SDNN"
        case .heartRateRecoveryOneMinute:   
            "Heart Rate Recovery (1 min)"
        case .atrialFibrillationBurden:     
            "Atrial Fibrillation Burden"
        case .walkingHeartRateAverage:      
            "Walking Heart Rate Average"
        case .heartbeatSeries:              
            "Heartbeat Series"
        case .electrocardiogram:            
            "Electrocardiogram"
        case .oxygenSaturation:             
            "Oxygen Saturation"
        case .bodyTemperature:              
            "Body Temperature"
        case .bloodPressure:                
            "Blood Pressure"
        case .bloodPressureSystolic:        
            "Blood Pressure Systolic"
        case .bloodPressureDiastolic:       
            "Blood Pressure Diastolic"
        case .respiratoryRate:              
            "Respiratory Rate"
        }
    }

    var identifier: HealthTypeIdentifier {
        switch self {
        case .heartRate:
                .quantity(.heartRate)
        case .lowHeartRateEvent:
                .category(.lowHeartRateEvent)
        case .highHeartRateEvent:
                .category(.highHeartRateEvent)
        case .irregularHeartRhythmEvent:
                .category(.irregularHeartRhythmEvent)
        case .restingHeartRate:
                .quantity(.restingHeartRate)
        case .heartRateVariabilitySDNN:
                .quantity(.heartRateVariabilitySDNN)
        case .heartRateRecoveryOneMinute:
                .quantity(.heartRateRecoveryOneMinute)
        case .atrialFibrillationBurden:
                .quantity(.atrialFibrillationBurden)
        case .walkingHeartRateAverage:
                .quantity(.walkingHeartRateAverage)
        case .heartbeatSeries:
                .heartbeatSeries
        case .electrocardiogram:
                .electrocardiogram
        case .oxygenSaturation:
                .quantity(.oxygenSaturation)
        case .bodyTemperature:
                .quantity(.bodyTemperature)
        case .bloodPressure:
                .correlation(.bloodPressure)
        case .bloodPressureSystolic:
                .quantity(.bloodPressureSystolic)
        case .bloodPressureDiastolic:
                .quantity(.bloodPressureDiastolic)
        case .respiratoryRate:
                .quantity(.respiratoryRate)
        }
    }

}

extension VitalsType: Identifiable {

    var id: Self {
        self
    }

}
