//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum NutritionType: CaseIterable, MeasurementType {
    
    case food
    case dietaryEnergyConsumed
    case dietaryCarbohydrates
    case dietaryFiber
    case dietarySugar
    case dietaryFatTotal
    case dietaryFatMonounsaturated
    case dietaryFatPolyunsaturated
    case dietaryFatSaturated
    case dietaryCholesterol
    case dietaryProtein
    case dietaryVitaminA
    case dietaryThiamin
    case dietaryRiboflavin
    case dietaryNiacin
    case dietaryPantothenicAcid
    case dietaryVitaminB6
    case dietaryBiotin
    case dietaryVitaminB12
    case dietaryVitaminC
    case dietaryVitaminD
    case dietaryVitaminE
    case dietaryVitaminK
    case dietaryFolate
    case dietaryCalcium
    case dietaryChloride
    case dietaryIron
    case dietaryMagnesium
    case dietaryPhosphorus
    case dietaryPotassium
    case dietarySodium
    case dietaryZinc
    case dietaryWater
    case dietaryCaffeine
    case dietaryChromium
    case dietaryCopper
    case dietaryIodine
    case dietaryManganese
    case dietaryMolybdenum
    case dietarySelenium
    
    var title: String {
        switch self {
        case .food:                         
            "Food"
        case .dietaryEnergyConsumed:        
            "Energy Consumed"
        case .dietaryCarbohydrates:         
            "Carbohydrates"
        case .dietaryFiber:                 
            "Fiber"
        case .dietarySugar:                 
            "Sugar"
        case .dietaryFatTotal:              
            "Total Fat"
        case .dietaryFatMonounsaturated:    
            "Monounsaturated Fat"
        case .dietaryFatPolyunsaturated:    
            "Polyunsaturated Fat"
        case .dietaryFatSaturated:          
            "Saturated Fat"
        case .dietaryCholesterol:           
            "Cholesterol"
        case .dietaryProtein:               
            "Protein"
        case .dietaryVitaminA:              
            "Vitamin A"
        case .dietaryThiamin:               
            "Thiamin (B1)"
        case .dietaryRiboflavin:            
            "Riboflavin (B2)"
        case .dietaryNiacin:                
            "Niacin (B3)"
        case .dietaryPantothenicAcid:       
            "Pantothenic Acid (B5)"
        case .dietaryVitaminB6:             
            "Vitamin B6"
        case .dietaryBiotin:                
            "Biotin (B7)"
        case .dietaryVitaminB12:            
            "Vitamin B12"
        case .dietaryVitaminC:              
            "Vitamin C"
        case .dietaryVitaminD:              
            "Vitamin D"
        case .dietaryVitaminE:              
            "Vitamin E"
        case .dietaryVitaminK:              
            "Vitamin K"
        case .dietaryFolate:                
            "Folate (B9)"
        case .dietaryCalcium:               
            "Calcium"
        case .dietaryChloride:              
            "Chloride"
        case .dietaryIron:                  
            "Iron"
        case .dietaryMagnesium:             
            "Magnesium"
        case .dietaryPhosphorus:            
            "Phosphorus"
        case .dietaryPotassium:             
            "Potassium"
        case .dietarySodium:                
            "Sodium"
        case .dietaryZinc:
            "Zinc"
        case .dietaryWater:                 
            "Water"
        case .dietaryCaffeine:
            "Caffeine"
        case .dietaryChromium:
            "Chromium"
        case .dietaryCopper:
            "Copper"
        case .dietaryIodine:
            "Iodine"
        case .dietaryManganese:
            "Manganese"
        case .dietaryMolybdenum:
            "Molybdenum"
        case .dietarySelenium:
            "Selenium"
        }
    }
    
    var identifier: HealthTypeIdentifier {
        switch self {
        case .food:
                .correlation(.food)
        case .dietaryEnergyConsumed:
                .quantity(.dietaryEnergyConsumed)
        case .dietaryCarbohydrates:
                .quantity(.dietaryCarbohydrates)
        case .dietaryFiber:
                .quantity(.dietaryFiber)
        case .dietarySugar:
                .quantity(.dietarySugar)
        case .dietaryFatTotal:
                .quantity(.dietaryFatTotal)
        case .dietaryFatMonounsaturated:
                .quantity(.dietaryFatMonounsaturated)
        case .dietaryFatPolyunsaturated:
                .quantity(.dietaryFatPolyunsaturated)
        case .dietaryFatSaturated:
                .quantity(.dietaryFatSaturated)
        case .dietaryCholesterol:
                .quantity(.dietaryCholesterol)
        case .dietaryProtein:
                .quantity(.dietaryProtein)
        case .dietaryVitaminA:
                .quantity(.dietaryVitaminA)
        case .dietaryThiamin:
                .quantity(.dietaryThiamin)
        case .dietaryRiboflavin:
                .quantity(.dietaryRiboflavin)
        case .dietaryNiacin:
                .quantity(.dietaryNiacin)
        case .dietaryPantothenicAcid:
                .quantity(.dietaryPantothenicAcid)
        case .dietaryVitaminB6:
                .quantity(.dietaryVitaminB6)
        case .dietaryBiotin:
                .quantity(.dietaryBiotin)
        case .dietaryVitaminB12:
                .quantity(.dietaryVitaminB12)
        case .dietaryVitaminC:
                .quantity(.dietaryVitaminC)
        case .dietaryVitaminD:
                .quantity(.dietaryVitaminD)
        case .dietaryVitaminE:
                .quantity(.dietaryVitaminE)
        case .dietaryVitaminK:
                .quantity(.dietaryVitaminK)
        case .dietaryFolate:
                .quantity(.dietaryFolate)
        case .dietaryCalcium:
                .quantity(.dietaryCalcium)
        case .dietaryChloride:
                .quantity(.dietaryChloride)
        case .dietaryIron:
                .quantity(.dietaryIron)
        case .dietaryMagnesium:
                .quantity(.dietaryMagnesium)
        case .dietaryPhosphorus:
                .quantity(.dietaryPhosphorus)
        case .dietaryPotassium:
                .quantity(.dietaryPotassium)
        case .dietarySodium:
                .quantity(.dietarySodium)
        case .dietaryZinc:
                .quantity(.dietaryZinc)
        case .dietaryWater:
                .quantity(.dietaryWater)
        case .dietaryCaffeine:
                .quantity(.dietaryCaffeine)
        case .dietaryChromium:
                .quantity(.dietaryChromium)
        case .dietaryCopper:
                .quantity(.dietaryCopper)
        case .dietaryIodine:
                .quantity(.dietaryIodine)
        case .dietaryManganese:
                .quantity(.dietaryManganese)
        case .dietaryMolybdenum:
                .quantity(.dietaryMolybdenum)
        case .dietarySelenium:
                .quantity(.dietarySelenium)
        }
    }
    
}

extension NutritionType: Identifiable {
    
    var id: Self {
        self
    }
    
}
