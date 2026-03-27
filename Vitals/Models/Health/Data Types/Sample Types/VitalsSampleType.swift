//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum VitalsSampleType: CaseIterable, SampleTypeProtocol {

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
        case .bloodPressureSystolic:
            "Blood Pressure Systolic"
        case .bloodPressureDiastolic:       
            "Blood Pressure Diastolic"
        case .respiratoryRate:              
            "Respiratory Rate"
        }
    }

    var type: SampleType {
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
        case .bloodPressureSystolic:
                .quantity(.bloodPressureSystolic)
        case .bloodPressureDiastolic:
                .quantity(.bloodPressureDiastolic)
        case .respiratoryRate:
                .quantity(.respiratoryRate)
        }
    }

    var category: SampleCategory {
        .vitals
    }

    var config: SampleConfiguration {
        switch self {
        case .heartRate, .walkingHeartRateAverage:
            return .init(.discreteAverage, chart: .line, dateInterval: Date.dailyInterval)
        case .restingHeartRate:
            return .init(.discreteAverage, chart: .line, dateInterval: Date.weeklyInterval)
        case .heartRateVariabilitySDNN:
            return .init(.discreteAverage, chart: .line, dateInterval: Date.weeklyInterval)
        case .heartRateRecoveryOneMinute:
            return .init(.mostRecent, chart: .line, dateInterval: Date.monthlyInterval)
        case .lowHeartRateEvent, .highHeartRateEvent, .irregularHeartRhythmEvent:
            return .init(.mostRecent, chart: .bar, dateInterval: Date.monthlyInterval)
        case .respiratoryRate:
            return .init(.discreteAverage, chart: .line, dateInterval: Date.weeklyInterval)
        case .bloodPressureSystolic, .bloodPressureDiastolic:
            return .init(.discreteAverage, chart: .line, dateInterval: Date.weeklyInterval)
        case .bodyTemperature:
            return .init(.discreteAverage, chart: .line, dateInterval: Date.weeklyInterval)
        case .oxygenSaturation:
            return .init(.discreteAverage, chart: .line, dateInterval: Date.dailyInterval)
        case .atrialFibrillationBurden:
            return .init(.discreteAverage, chart: .line, dateInterval: Date.monthlyInterval)
        case .heartbeatSeries, .electrocardiogram:
            return .init(.mostRecent, chart: .line, dateInterval: Date.dailyInterval)
        }
    }

}

extension VitalsSampleType: Identifiable {

    var id: Self {
        self
    }

}
