//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import HealthKit

enum ActivitySampleType: CaseIterable, SampleTypeProtocol {

    case stepCount
    case distanceWalkingRunning
    case runningSpeed
    case runningStrideLength
    case runningPower
    case runningGroundContactTime
    case runningVerticalOscillation
    case distanceCycling
    case pushCount
    case distanceWheelchair
    case distanceSwimming
    case distanceDownhillSnowSports
    case basalEnergyBurned
    case activeEnergyBurned
    case flightsClimbed
    case nikeFuel
    case appleExerciseTime
    case appleMoveTime
    case appleStandHour
    case appleStandTime
    case vo2Max
    case lowCardioFitnessEvent

    var title: String {
        switch self {
        case .stepCount:
            "Step Count"
        case .distanceWalkingRunning:
            "Distance Walking & Running"
        case .runningSpeed:
            "Running Speed"
        case .runningStrideLength:
            "Running Stride Length"
        case .runningPower:
            "Running Power"
        case .runningGroundContactTime:
            "Running Ground Contact Time"
        case .runningVerticalOscillation:
            "Running Vertical Oscillation"
        case .distanceCycling:
            "Distance Cycling"
        case .pushCount:
            "Push Count"
        case .distanceWheelchair:
            "Distance Wheelchair"
        case .distanceSwimming:
            "Distance Swimming"
        case .distanceDownhillSnowSports:
            "Distance Downhill Snow Sports"
        case .basalEnergyBurned:
            "Basal Energy Burned"
        case .activeEnergyBurned:
            "Active Energy Burned"
        case .flightsClimbed:
            "Flights Climbed"
        case .nikeFuel:
            "Nike Fuel"
        case .appleExerciseTime:
            "Exercise Time"
        case .appleMoveTime:
            "Move Time"
        case .appleStandHour:
            "Stand Hour"
        case .appleStandTime:
            "Stand Time"
        case .vo2Max:
            "VO2 Max"
        case .lowCardioFitnessEvent:
            "Low Cardio Fitness Event"
        }
    }

    var type: SampleType {
        switch self {
        case .stepCount:
                .quantity(.stepCount)
        case .distanceWalkingRunning:
                .quantity(.distanceWalkingRunning)
        case .runningSpeed:
                .quantity(.runningSpeed)
        case .runningStrideLength:
                .quantity(.runningStrideLength)
        case .runningPower:
                .quantity(.runningPower)
        case .runningGroundContactTime:
                .quantity(.runningGroundContactTime)
        case .runningVerticalOscillation:
                .quantity(.runningVerticalOscillation)
        case .distanceCycling:
                .quantity(.distanceCycling)
        case .pushCount:
                .quantity(.pushCount)
        case .distanceWheelchair:
                .quantity(.distanceWheelchair)
        case .distanceSwimming:
                .quantity(.distanceSwimming)
        case .distanceDownhillSnowSports:
                .quantity(.distanceDownhillSnowSports)
        case .basalEnergyBurned:
                .quantity(.basalEnergyBurned)
        case .activeEnergyBurned:
                .quantity(.activeEnergyBurned)
        case .flightsClimbed:
                .quantity(.flightsClimbed)
        case .nikeFuel:
                .quantity(.nikeFuel)
        case .appleExerciseTime:
                .quantity(.appleExerciseTime)
        case .appleMoveTime:
                .quantity(.appleMoveTime)
        case .appleStandHour:
                .category(.appleStandHour)
        case .appleStandTime:
                .quantity(.appleStandTime)
        case .vo2Max:
                .quantity(.vo2Max)
        case .lowCardioFitnessEvent:
                .category(.lowCardioFitnessEvent)
        }
    }
    
    var category: SampleCategory {
        .activity
    }
    
}

extension ActivitySampleType {
    
    var config: SampleConfiguration {
        switch self {
        case .stepCount:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .flightsClimbed:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .pushCount:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .distanceWalkingRunning:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .distanceCycling:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .distanceSwimming:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .distanceWheelchair:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .distanceDownhillSnowSports:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .activeEnergyBurned:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .basalEnergyBurned:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .appleExerciseTime:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .appleMoveTime:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .appleStandTime:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .appleStandHour:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .nikeFuel:
            return .init(.cumulativeSum, chartStyle: .bar, summaryLabel: .total, dateInterval: Date.dailyInterval)
        case .runningSpeed:
            return .init(.discreteAverage, chartStyle: .line, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        case .runningStrideLength:
            return .init(.discreteAverage, chartStyle: .line, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        case .runningPower:
            return .init(.discreteAverage, chartStyle: .line, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        case .runningGroundContactTime:
            return .init(.discreteAverage, chartStyle: .line, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        case .runningVerticalOscillation:
            return .init(.discreteAverage, chartStyle: .line, summaryLabel: .average, dateInterval: Date.weeklyInterval)
        case .vo2Max:
            return .init(.discreteAverage, chartStyle: .interpolatedLine, summaryLabel: .average, dateInterval: Date.monthlyInterval)
        case .lowCardioFitnessEvent:
            return .init(.mostRecent, chartStyle: .bar, summaryLabel: .latest, dateInterval: Date.monthlyInterval)
        }
    }
    
}

extension ActivitySampleType: Identifiable {
    
    var id: Self {
        self
    }
    
}
