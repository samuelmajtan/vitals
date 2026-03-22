//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum MobilityType: CaseIterable, MeasurementTypeProtocol {

    case appleWalkingSteadiness
    case appleWalkingSteadinessEvent
    case sixMinuteWalkTestDistance
    case walkingSpeed
    case walkingAsymmetryPercentage
    case walkingDoubleSupportPercentage
    case stairAscentSpeed
    case stairDescentSpeed

    var title: String {
        switch self {
        case .appleWalkingSteadiness:
            "Apple Walking Steadiness"
        case .appleWalkingSteadinessEvent:
            "Apple Walking Steadiness Event"
        case .sixMinuteWalkTestDistance:
            "Six Minute Walk Test Distance"
        case .walkingSpeed:
            "Walking Speed"
        case .walkingAsymmetryPercentage:
            "Walking Asymmetry Percentage"
        case .walkingDoubleSupportPercentage:
            "Walking Double Support Percentage"
        case .stairAscentSpeed:
            "Stair Ascent Speed"
        case .stairDescentSpeed:
            "Stair Descent Speed"
        }
    }

    var type: MeasurementType {
        switch self {
        case .appleWalkingSteadiness:
                .quantity(.appleWalkingSteadiness)
        case .appleWalkingSteadinessEvent:
                .category(.appleWalkingSteadinessEvent)
        case .sixMinuteWalkTestDistance:
                .quantity(.sixMinuteWalkTestDistance)
        case .walkingSpeed:
                .quantity(.walkingSpeed)
        case .walkingAsymmetryPercentage:
                .quantity(.walkingStepLength)
        case .walkingDoubleSupportPercentage:
                .quantity(.walkingDoubleSupportPercentage)
        case .stairAscentSpeed:
                .quantity(.stairAscentSpeed)
        case .stairDescentSpeed:
                .quantity(.stairDescentSpeed)
        }
    }

}

extension MobilityType: Identifiable {

    var id: Self {
        self
    }

}
