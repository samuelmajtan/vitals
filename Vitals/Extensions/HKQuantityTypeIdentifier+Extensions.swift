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
            
            // MARK: - Vitals
            
        case .heartRate:                            return .count().unitDivided(by: .minute())
        case .restingHeartRate:                     return .count().unitDivided(by: .minute())
        case .walkingHeartRateAverage:              return .count().unitDivided(by: .minute())
        case .heartRateVariabilitySDNN:             return .secondUnit(with: .milli)
        case .heartRateRecoveryOneMinute:           return .count().unitDivided(by: .minute())
        case .atrialFibrillationBurden:             return .percent()
        case .oxygenSaturation:                     return .percent()
        case .bodyTemperature:                      return .degreeCelsius()
        case .bloodPressureSystolic:                return .millimeterOfMercury()
        case .bloodPressureDiastolic:               return .millimeterOfMercury()
        case .respiratoryRate:                      return .count().unitDivided(by: .minute())
        case .vo2Max:                               return HKUnit(from: "ml/kg*min")
            
            // MARK: - Activity
            
        case .stepCount:                            return .count()
        case .flightsClimbed:                       return .count()
        case .pushCount:                            return .count()
        case .nikeFuel:                             return .kilocalorie()
        case .distanceWalkingRunning:               return .meterUnit(with: .kilo)
        case .distanceCycling:                      return .meterUnit(with: .kilo)
        case .distanceSwimming:                     return .meterUnit(with: .kilo)
        case .distanceWheelchair:                   return .meterUnit(with: .kilo)
        case .distanceDownhillSnowSports:           return .meterUnit(with: .kilo)
        case .activeEnergyBurned:                   return .kilocalorie()
        case .basalEnergyBurned:                    return .kilocalorie()
        case .appleExerciseTime:                    return .minute()
        case .appleMoveTime:                        return .minute()
        case .appleStandTime:                       return .minute()
        case .runningSpeed:                         return .meterUnit(with: .kilo).unitDivided(by: .hour())
        case .runningStrideLength:                  return .meterUnit(with: .centi)
        case .runningPower:                         return HKUnit.watt()
        case .runningGroundContactTime:             return .secondUnit(with: .milli)
        case .runningVerticalOscillation:           return .meterUnit(with: .centi)
            
            // MARK: - Mobility
            
        case .walkingSpeed:                         return .meterUnit(with: .kilo).unitDivided(by: .hour())
        case .walkingAsymmetryPercentage:           return .percent()
        case .walkingDoubleSupportPercentage:       return .percent()
        case .walkingStepLength:                    return .meterUnit(with: .centi)
        case .stairAscentSpeed:                     return .meter().unitDivided(by: .second())
        case .stairDescentSpeed:                    return .meter().unitDivided(by: .second())
        case .sixMinuteWalkTestDistance:            return .meter()
        case .appleWalkingSteadiness:               return .percent()
            
            // MARK: - Body Measurements
            
        case .bodyMass:                             return .gramUnit(with: .kilo)
        case .leanBodyMass:                         return .gramUnit(with: .kilo)
        case .height:                               return .meterUnit(with: .centi)
        case .bodyMassIndex:                        return .count()
        case .bodyFatPercentage:                    return .percent()
        case .waistCircumference:                   return .meterUnit(with: .centi)
            
            // MARK: - Hearing
            
        case .environmentalAudioExposure:           return .decibelAWeightedSoundPressureLevel()
        case .headphoneAudioExposure:               return .decibelAWeightedSoundPressureLevel()
            
            // MARK: - Sleep
            
        case .appleSleepingWristTemperature:        return .degreeCelsius()
            
            // MARK: - Nutrition
            
        case .dietaryEnergyConsumed:                return .kilocalorie()
        case .dietaryCarbohydrates:                 return .gramUnit(with: .none)
        case .dietaryFiber:                         return .gramUnit(with: .none)
        case .dietarySugar:                         return .gramUnit(with: .none)
        case .dietaryFatTotal:                      return .gramUnit(with: .none)
        case .dietaryFatMonounsaturated:            return .gramUnit(with: .none)
        case .dietaryFatPolyunsaturated:            return .gramUnit(with: .none)
        case .dietaryFatSaturated:                  return .gramUnit(with: .none)
        case .dietaryCholesterol:                   return .gramUnit(with: .milli)
        case .dietaryProtein:                       return .gramUnit(with: .none)
        case .dietaryVitaminA:                      return .gramUnit(with: .micro)
        case .dietaryThiamin:                       return .gramUnit(with: .milli)
        case .dietaryRiboflavin:                    return .gramUnit(with: .milli)
        case .dietaryNiacin:                        return .gramUnit(with: .milli)
        case .dietaryPantothenicAcid:               return .gramUnit(with: .milli)
        case .dietaryVitaminB6:                     return .gramUnit(with: .milli)
        case .dietaryBiotin:                        return .gramUnit(with: .micro)
        case .dietaryVitaminB12:                    return .gramUnit(with: .micro)
        case .dietaryVitaminC:                      return .gramUnit(with: .milli)
        case .dietaryVitaminD:                      return .gramUnit(with: .micro)
        case .dietaryVitaminE:                      return .gramUnit(with: .milli)
        case .dietaryVitaminK:                      return .gramUnit(with: .micro)
        case .dietaryFolate:                        return .gramUnit(with: .micro)
        case .dietaryCalcium:                       return .gramUnit(with: .milli)
        case .dietaryChloride:                      return .gramUnit(with: .milli)
        case .dietaryIron:                          return .gramUnit(with: .milli)
        case .dietaryMagnesium:                     return .gramUnit(with: .milli)
        case .dietaryPhosphorus:                    return .gramUnit(with: .milli)
        case .dietaryPotassium:                     return .gramUnit(with: .milli)
        case .dietarySodium:                        return .gramUnit(with: .milli)
        case .dietaryZinc:                          return .gramUnit(with: .milli)
        case .dietaryWater:                         return .liter()
        case .dietaryCaffeine:                      return .gramUnit(with: .milli)
        case .dietaryChromium:                      return .gramUnit(with: .micro)
        case .dietaryCopper:                        return .gramUnit(with: .milli)
        case .dietaryIodine:                        return .gramUnit(with: .micro)
        case .dietaryManganese:                     return .gramUnit(with: .milli)
        case .dietaryMolybdenum:                    return .gramUnit(with: .micro)
        case .dietarySelenium:                      return .gramUnit(with: .micro)
            
        default:                                    return .count()
        }
    }
    
    var displayUnit: String {
        switch self {
            
            // MARK: - Vitas

        case .heartRate,
                .restingHeartRate,
                .walkingHeartRateAverage,
                .heartRateRecoveryOneMinute:           
            return "BPM"
        case .heartRateVariabilitySDNN:             
            return "ms"
        case .atrialFibrillationBurden,
                .oxygenSaturation,
                .bodyFatPercentage,
                .walkingAsymmetryPercentage,
                .walkingDoubleSupportPercentage,
                .appleWalkingSteadiness:               
            return "%"
        case .bodyTemperature,
                .appleSleepingWristTemperature:        
            return "°C"
        case .bloodPressureSystolic,
                .bloodPressureDiastolic:               
            return "mmHg"
        case .respiratoryRate:                      
            return "br/min"
        case .vo2Max:                               
            return "ml/kg/min"
            
            // MARK: - Activity

        case .stepCount,
                .flightsClimbed,
                .pushCount:                            
            return ""
        case .distanceWalkingRunning,
                .distanceCycling,
                .distanceSwimming,
                .distanceWheelchair,
                .distanceDownhillSnowSports:        
            return "km"
        case .activeEnergyBurned,
                .basalEnergyBurned,
                .dietaryEnergyConsumed:                
            return "kcal"
        case .appleExerciseTime,
                .appleMoveTime,
                .appleStandTime:                       
            return "min"
        case .runningSpeed,
                .walkingSpeed:                         
            return "km/h"
        case .runningStrideLength,
                .walkingStepLength:                    
            return "cm"
        case .runningPower:                         
            return "W"
        case .runningGroundContactTime:             
            return "ms"
        case .runningVerticalOscillation:           
            return "cm"
        case .nikeFuel:                             
            return "kcal"
            
            // MARK: - Mobility
            
        case .stairAscentSpeed,
                .stairDescentSpeed:                    
            return "m/s"
        case .sixMinuteWalkTestDistance:            
            return "m"
            
            // MARK: - Body Measurements
            
        case .bodyMass,
                .leanBodyMass:                         
            return "kg"
        case .height,
                .waistCircumference:                   
            return "cm"
        case .bodyMassIndex:                        
            return "BMI"
            
            // MARK: - Hearing
            
        case .environmentalAudioExposure,
                .headphoneAudioExposure:               
            return "dB"
            
            // MARK: - Nutrition (grams)
            
        case .dietaryCarbohydrates,
                .dietaryFiber,
                .dietarySugar,
                .dietaryFatTotal,
                .dietaryFatMonounsaturated,
                .dietaryFatPolyunsaturated,
                .dietaryFatSaturated,
                .dietaryProtein:                       
            return "g"
        case .dietaryCholesterol,
                .dietaryThiamin,
                .dietaryRiboflavin,
                .dietaryNiacin,
                .dietaryPantothenicAcid,
                .dietaryVitaminB6,
                .dietaryVitaminC,
                .dietaryVitaminE,
                .dietaryCalcium,
                .dietaryChloride,
                .dietaryIron,
                .dietaryMagnesium,
                .dietaryPhosphorus,
                .dietaryPotassium,
                .dietarySodium,
                .dietaryZinc,
                .dietaryCaffeine,
                .dietaryCopper,
                .dietaryManganese:                     
            return "mg"
        case .dietaryVitaminA,
                .dietaryBiotin,
                .dietaryVitaminB12,
                .dietaryVitaminD,
                .dietaryVitaminK,
                .dietaryFolate,
                .dietaryChromium,
                .dietaryIodine,
                .dietaryMolybdenum,
                .dietarySelenium:
            return "μg"
        case .dietaryWater:                         
            return "L"
        default:                                    return ""
        }
    }
}
