//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Testing
@testable import AnalysisKit

@Suite("LinearRegression Tests")
struct LinearRegressionTests {

    @Test("Returns nil for fewer than 2 points")
    func tooFewPoints() {
        #expect(LinearRegression.fit([(x: 1.0, y: 2.0)]) == nil)
        #expect(LinearRegression.fit([42.0]) == nil)
    }

    @Test("Perfect line y = 2x + 1")
    func perfectLine() {
        let points: [(x: Double, y: Double)] = [(0, 1), (1, 3), (2, 5), (3, 7), (4, 9)]
        let result = LinearRegression.fit(points)!
        #expect(abs(result.slope - 2.0) < 0.001)
        #expect(abs(result.intercept - 1.0) < 0.001)
        #expect(abs(result.rSquared - 1.0) < 0.001)
        #expect(result.trend == .increasing)
    }

    @Test("Decreasing line y = -3x + 10")
    func decreasingLine() {
        let points: [(x: Double, y: Double)] = [(0, 10), (1, 7), (2, 4), (3, 1)]
        let result = LinearRegression.fit(points)!
        #expect(abs(result.slope - (-3.0)) < 0.001)
        #expect(abs(result.intercept - 10.0) < 0.001)
        #expect(result.trend == .decreasing)
    }

    @Test("Flat data is stable trend")
    func stableTrend() {
        let values = [10.0, 10.01, 9.99, 10.0, 10.01]
        let result = LinearRegression.fit(values)!
        #expect(result.trend == .stable)
    }

    @Test("Fit from values uses index as x")
    func fitFromValues() {
        // y = x (slope=1, intercept=0)
        let result = LinearRegression.fit([0.0, 1.0, 2.0, 3.0, 4.0])!
        #expect(abs(result.slope - 1.0) < 0.001)
        #expect(abs(result.intercept) < 0.001)
    }

    @Test("Predict uses slope and intercept")
    func predict() {
        let result = LinearRegressionResult(slope: 2.0, intercept: 1.0, rSquared: 1.0, trend: .increasing)
        let predicted = LinearRegression.predict(x: 5.0, using: result)
        #expect(abs(predicted - 11.0) < 0.001)
    }

    @Test("R-squared is between 0 and 1 for noisy data")
    func rSquaredRange() {
        let values = [10.0, 12.0, 11.0, 14.0, 13.0, 16.0, 15.0]
        let result = LinearRegression.fit(values)!
        #expect(result.rSquared >= 0.0)
        #expect(result.rSquared <= 1.0)
    }

    @Test("Returns nil for constant x values")
    func constantX() {
        let points: [(x: Double, y: Double)] = [(1, 2), (1, 3), (1, 4)]
        #expect(LinearRegression.fit(points) == nil)
    }

}
