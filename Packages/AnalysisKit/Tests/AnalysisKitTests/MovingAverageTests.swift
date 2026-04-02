//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Testing
@testable import AnalysisKit

@Suite("MovingAverage Tests")
struct MovingAverageTests {

    // MARK: - SMA

    @Test("SMA returns nil for invalid inputs")
    func smaInvalidInputs() {
        #expect(MovingAverage.sma([], windowSize: 3) == nil)
        #expect(MovingAverage.sma([1, 2], windowSize: 3) == nil)
        #expect(MovingAverage.sma([1, 2, 3], windowSize: 0) == nil)
    }

    @Test("SMA with window=1 returns original values")
    func smaWindow1() {
        let result = MovingAverage.sma([1, 2, 3, 4, 5], windowSize: 1)!
        #expect(result.compactMap { $0 } == [1, 2, 3, 4, 5])
    }

    @Test("SMA first (window-1) values are nil")
    func smaLeadingNils() {
        let result = MovingAverage.sma([1, 2, 3, 4, 5], windowSize: 3)!
        #expect(result[0] == nil)
        #expect(result[1] == nil)
        #expect(result[2] != nil)
    }

    @Test("SMA of [1, 2, 3, 4, 5] with window=3")
    func smaValues() {
        let result = MovingAverage.sma([1, 2, 3, 4, 5], windowSize: 3)!
        #expect(abs(result[2]! - 2.0) < 0.001) // (1+2+3)/3
        #expect(abs(result[3]! - 3.0) < 0.001) // (2+3+4)/3
        #expect(abs(result[4]! - 4.0) < 0.001) // (3+4+5)/3
    }

    // MARK: - EMA

    @Test("EMA returns nil for invalid inputs")
    func emaInvalidInputs() {
        #expect(MovingAverage.ema([], windowSize: 3) == nil)
        #expect(MovingAverage.ema([1, 2], windowSize: 3) == nil)
        #expect(MovingAverage.ema([1, 2, 3], windowSize: 0) == nil)
    }

    @Test("EMA returns correct number of values")
    func emaCount() {
        let result = MovingAverage.ema([1, 2, 3, 4, 5], windowSize: 3)!
        #expect(result.count == 5)
    }

    @Test("EMA seed is SMA of first window")
    func emaSeed() {
        let result = MovingAverage.ema([3, 6, 9, 12, 15], windowSize: 3)!
        // Seed = (3+6+9)/3 = 6.0
        #expect(abs(result[0] - 6.0) < 0.001)
    }

    @Test("EMA responds to recent values more than older ones")
    func emaWeighting() {
        // After a step change, EMA should move towards the new value
        let values = [10.0, 10.0, 10.0, 20.0, 20.0, 20.0]
        let result = MovingAverage.ema(values, windowSize: 3)!
        // After step change, values should be increasing towards 20
        #expect(result[3] > result[2])
        #expect(result[4] > result[3])
        #expect(result[5] > result[4])
    }

}
