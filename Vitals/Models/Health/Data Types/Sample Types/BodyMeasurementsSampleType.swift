//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum BodyMeasurementsSampleType: CaseIterable, SampleTypeProtocol {

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

    var type: SampleType {
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
    
    var category: SampleCategory {
        .bodyMeasurements
    }
    
}

extension BodyMeasurementsSampleType {
    
    var config: SampleConfiguration {
        switch self {
        case .height:
            return .init(.mostRecent, chartStyle: .line, summaryLabel: .latest, dateInterval: Date.yearlyInterval)
        case .bodyMass:
            return .init(.discreteAverage, chartStyle: .interpolatedLine, summaryLabel: .average, dateInterval: Date.monthlyInterval)
        case .leanBodyMass:
            return .init(.discreteAverage, chartStyle: .interpolatedLine, summaryLabel: .average, dateInterval: Date.monthlyInterval)
        case .bodyMassIndex:
            return .init(.discreteAverage, chartStyle: .interpolatedLine, summaryLabel: .average, dateInterval: Date.monthlyInterval)
        case .bodyFatPercentage:
            return .init(.discreteAverage, chartStyle: .interpolatedLine, summaryLabel: .average, dateInterval: Date.monthlyInterval)
        case .waistCircumference:
            return .init(.mostRecent, chartStyle: .line, summaryLabel: .latest, dateInterval: Date.monthlyInterval)
        }
    }
    
}

extension BodyMeasurementsSampleType: Identifiable {

    var id: Self {
        self
    }

}
