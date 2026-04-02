//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum MobilitySampleType: CaseIterable, SampleTypeProtocol {

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

    var type: SampleType {
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

    var category: SampleCategory {
        .mobility
    }
    
}

extension MobilitySampleType {
    
    var config: SampleConfiguration {
        switch self {
        case .walkingSpeed:
            return .init(.discreteAverage, chartStyle: .line, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        case .walkingAsymmetryPercentage:
            return .init(.discreteAverage, chartStyle: .interpolatedLine, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        case .walkingDoubleSupportPercentage:
            return .init(.discreteAverage, chartStyle: .interpolatedLine, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        case .stairAscentSpeed:
            return .init(.discreteAverage, chartStyle: .line, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        case .stairDescentSpeed:
            return .init(.discreteAverage, chartStyle: .line, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        case .sixMinuteWalkTestDistance:
            return .init(.mostRecent, chartStyle: .bar, summaryLabel: .latest, dateInterval: Date.monthlyInterval)
        case .appleWalkingSteadiness:
            return .init(.discreteAverage, chartStyle: .interpolatedLine, summaryLabel: .average, dateInterval: Date.monthlyInterval)
        case .appleWalkingSteadinessEvent:
            return .init(.mostRecent, chartStyle: .bar, summaryLabel: .latest, dateInterval: Date.weeklyInterval)
        }
    }
    
}

extension MobilitySampleType: Identifiable {

    var id: Self {
        self
    }

}
