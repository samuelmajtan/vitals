//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum CharacteristicType: CaseIterable {
    
    case activityMoveMode
    case biologicalSex
    case bloodType
    case dateOfBirth
    case fitzpatrickSkinType
    case wheelchairUse
    
    var title: String {
        switch self {
        case .activityMoveMode:
            "Activity Move Mode"
        case .biologicalSex:
            "Biological Sex"
        case .bloodType:
            "Blood Type"
        case .dateOfBirth:
            "Date of Birth"
        case .fitzpatrickSkinType:
            "Fitzpatrick Skin Type"
        case .wheelchairUse:
            "Wheelchair Use"
        }
    }
    
    var type: HKCharacteristicTypeIdentifier {
        switch self {
        case .activityMoveMode:
                .activityMoveMode
        case .biologicalSex:
                .biologicalSex
        case .bloodType:
                .bloodType
        case .dateOfBirth:
                .dateOfBirth
        case .fitzpatrickSkinType:
                .fitzpatrickSkinType
        case .wheelchairUse:
                .wheelchairUse
        }
    }
    
}

extension CharacteristicType: Identifiable {

    var id: Self {
        self
    }

}
