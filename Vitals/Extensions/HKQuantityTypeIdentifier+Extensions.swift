//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

extension HKQuantityTypeIdentifier {
    
    var defaultUnit: HKUnit {
        switch self {
        case .heartRate:
            return .count().unitDivided(by: .minute())
        case .restingHeartRate:
            return .count().unitDivided(by: .minute())
        case .walkingHeartRateAverage:
            return .count().unitDivided(by: .minute())
        case .heartRateVariabilitySDNN:
            return .secondUnit(with: .milli)
        case .vo2Max:
            return HKUnit(from: "ml/kg*min")
        case .stepCount:
            return .count()
        case .distanceWalkingRunning:
            return .meterUnit(with: .kilo)
        case .flightsClimbed:
            return .count()
        case .activeEnergyBurned:
            return .kilocalorie()
        case .basalEnergyBurned:
            return .kilocalorie()
        case .respiratoryRate:
            return .count().unitDivided(by: .minute())
        case .oxygenSaturation:
            return .percent()
        case .bodyMass:
            return .gramUnit(with: .kilo)
        case .height:
            return .meterUnit(with: .centi)
        case .bodyMassIndex:
            return .count()
        case .bodyFatPercentage:
            return .percent()
        case .leanBodyMass:
            return .gramUnit(with: .kilo)
        case .bodyTemperature:
            return .degreeCelsius()
        case .bloodGlucose:
            return HKUnit(from: "mmol/L")
        case .bloodPressureSystolic:
            return .millimeterOfMercury()
        case .bloodPressureDiastolic:
            return .millimeterOfMercury()
        default:
            return .count()
        }
    }
    
    var displayUnit: String {
        switch self {
        case .heartRate, .restingHeartRate, .walkingHeartRateAverage:
            return "BPM"
        case .heartRateVariabilitySDNN:
            return "ms"
        case .vo2Max:
            return "ml/kg/min"
        case .stepCount, .flightsClimbed:
            return ""
        case .distanceWalkingRunning:
            return "km"
        case .activeEnergyBurned, .basalEnergyBurned:
            return "kcal"
        case .respiratoryRate:
            return "dych/min"
        case .oxygenSaturation, .bodyFatPercentage:
            return "%"
        case .bodyMass, .leanBodyMass:
            return "kg"
        case .height:
            return "cm"
        case .bodyTemperature:
            return "°C"
        case .bloodGlucose:
            return "mmol/L"
        case .bloodPressureSystolic, .bloodPressureDiastolic:
            return "mmHg"
        default:
            return ""
        }
    }
}
