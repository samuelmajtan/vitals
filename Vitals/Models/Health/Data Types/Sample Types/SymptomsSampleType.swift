//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum SymptomSampleType: CaseIterable, SampleTypeProtocol {

    case abdominalCramps
    case bloating
    case constipation
    case diarrhea
    case heartburn
    case nausea
    case vomiting
    case appetiteChanges
    case chills
    case dizziness
    case fainting
    case fatigue
    case fever
    case generalizedBodyAche
    case hotFlashes
    case chestTightnessOrPain
    case coughing
    case rapidPoundingOrFlutteringHeartbeat
    case shortnessOfBreath
    case skippedHeartbeat
    case wheezing
    case lowerBackPain
    case headache
    case memoryLapse
    case moodChanges
    case lossOfSmell
    case lossOfTaste
    case runnyNose
    case soreThroat
    case sinusCongestion
    case breastPain
    case pelvicPain
    case vaginalDryness
    case acne
    case drySkin
    case hairLoss
    case nightSweats
    case sleepChanges
    case bladderIncontinence

    var title: String {
        switch self {
        case .abdominalCramps:                      
            "Abdominal Cramps"
        case .bloating:                             
            "Bloating"
        case .constipation:
            "Constipation"
        case .diarrhea:                             
            "Diarrhea"
        case .heartburn:                            
            "Heartburn"
        case .nausea:                               
            "Nausea"
        case .vomiting:                             
            "Vomiting"
        case .appetiteChanges:                      
            "Appetite Changes"
        case .chills:                               
            "Chills"
        case .dizziness:                            
            "Dizziness"
        case .fainting:                             
            "Fainting"
        case .fatigue:
            "Fatigue"
        case .fever:                                
            "Fever"
        case .generalizedBodyAche:                  
            "Generalized Body Ache"
        case .hotFlashes:                           
            "Hot Flashes"
        case .chestTightnessOrPain:                 
            "Chest Tightness or Pain"
        case .coughing:                             
            "Coughing"
        case .rapidPoundingOrFlutteringHeartbeat:   
            "Rapid Pounding or Fluttering Heartbeat"
        case .shortnessOfBreath:                    
            "Shortness of Breath"
        case .skippedHeartbeat:                     
            "Skipped Heartbeat"
        case .wheezing:                             
            "Wheezing"
        case .lowerBackPain:                        
            "Lower Back Pain"
        case .headache:                             
            "Headache"
        case .memoryLapse:                          
            "Memory Lapse"
        case .moodChanges:                          
            "Mood Changes"
        case .lossOfSmell:                          
            "Loss of Smell"
        case .lossOfTaste:                          
            "Loss of Taste"
        case .runnyNose:                            
            "Runny Nose"
        case .soreThroat:                           
            "Sore Throat"
        case .sinusCongestion:                      
            "Sinus Congestion"
        case .breastPain:                           
            "Breast Pain"
        case .pelvicPain:                           
            "Pelvic Pain"
        case .vaginalDryness:                       
            "Vaginal Dryness"
        case .acne:                                 
            "Acne"
        case .drySkin:                              
            "Dry Skin"
        case .hairLoss:                             
            "Hair Loss"
        case .nightSweats:                          
            "Night Sweats"
        case .sleepChanges:                         
            "Sleep Changes"
        case .bladderIncontinence:                  
            "Bladder Incontinence"
        }
    }

    var type: SampleType {
        switch self {
        case .abdominalCramps:
                .category(.abdominalCramps)
        case .bloating:
                .category(.bloating)
        case .constipation:
                .category(.constipation)
        case .diarrhea:
                .category(.diarrhea)
        case .heartburn:
                .category(.heartburn)
        case .nausea:
                .category(.nausea)
        case .vomiting:
                .category(.vomiting)
        case .appetiteChanges:
                .category(.appetiteChanges)
        case .chills:
                .category(.chills)
        case .dizziness:
                .category(.dizziness)
        case .fainting:
                .category(.fainting)
        case .fatigue:
                .category(.fatigue)
        case .fever:
                .category(.fever)
        case .generalizedBodyAche:
                .category(.generalizedBodyAche)
        case .hotFlashes:
                .category(.hotFlashes)
        case .chestTightnessOrPain:
                .category(.chestTightnessOrPain)
        case .coughing:
                .category(.coughing)
        case .rapidPoundingOrFlutteringHeartbeat:
                .category(.rapidPoundingOrFlutteringHeartbeat)
        case .shortnessOfBreath:
                .category(.shortnessOfBreath)
        case .skippedHeartbeat:
                .category(.skippedHeartbeat)
        case .wheezing:
                .category(.wheezing)
        case .lowerBackPain:
                .category(.lowerBackPain)
        case .headache:
                .category(.headache)
        case .memoryLapse:
                .category(.memoryLapse)
        case .moodChanges:
                .category(.moodChanges)
        case .lossOfSmell:
                .category(.lossOfSmell)
        case .lossOfTaste:
                .category(.lossOfTaste)
        case .runnyNose:
                .category(.runnyNose)
        case .soreThroat:
                .category(.soreThroat)
        case .sinusCongestion:
                .category(.sinusCongestion)
        case .breastPain:
                .category(.breastPain)
        case .pelvicPain:
                .category(.pelvicPain)
        case .vaginalDryness:
                .category(.vaginalDryness)
        case .acne:
                .category(.acne)
        case .drySkin:
                .category(.drySkin)
        case .hairLoss:
                .category(.hairLoss)
        case .nightSweats:
                .category(.nightSweats)
        case .sleepChanges:
                .category(.sleepChanges)
        case .bladderIncontinence:
                .category(.bladderIncontinence)
        }
    }
    
    var category: SampleCategory {
        .symptoms
    }
    
    var config: SampleConfiguration {
        switch self {
        default:
            return .init(.mostRecent, chart: .bar, dateInterval: Date.monthlyInterval)
        }
    }

}

extension SymptomSampleType: Identifiable {

    var id: Self {
        self
    }

}
