//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Testing
@testable import AnalysisKit

@Suite("Interpolation Tests")
struct InterpolationTests {

    // MARK: - Linear

    @Test("Linear returns nil for fewer than 2 points")
    func linearTooFewPoints() {
        #expect(Interpolation.linear(at: 1.0, points: [(x: 0, y: 0)]) == nil)
    }

    @Test("Linear returns nil for out of range x")
    func linearOutOfRange() {
        let points: [(x: Double, y: Double)] = [(0, 0), (10, 10)]
        #expect(Interpolation.linear(at: -1.0, points: points) == nil)
        #expect(Interpolation.linear(at: 11.0, points: points) == nil)
    }

    @Test("Linear interpolation at midpoint")
    func linearMidpoint() {
        let points: [(x: Double, y: Double)] = [(0, 0), (10, 10)]
        let result = Interpolation.linear(at: 5.0, points: points)!
        #expect(abs(result - 5.0) < 0.001)
    }

    @Test("Linear interpolation at known point returns exact value")
    func linearExactPoint() {
        let points: [(x: Double, y: Double)] = [(0, 0), (5, 10), (10, 20)]
        let result = Interpolation.linear(at: 5.0, points: points)!
        #expect(abs(result - 10.0) < 0.001)
    }

    // MARK: - Linear Fill

    @Test("Linear fill with no known values returns empty")
    func linearFillNoKnown() {
        let result = Interpolation.linearFill([nil, nil, nil])
        #expect(result.isEmpty)
    }

    @Test("Linear fill with single known value fills everything")
    func linearFillSingleKnown() {
        let result = Interpolation.linearFill([nil, 5.0, nil])
        #expect(result == [5.0, 5.0, 5.0])
    }

    @Test("Linear fill interpolates interior gaps")
    func linearFillInterior() {
        let result = Interpolation.linearFill([0.0, nil, nil, 6.0])
        #expect(abs(result[0] - 0.0) < 0.001)
        #expect(abs(result[1] - 2.0) < 0.001)
        #expect(abs(result[2] - 4.0) < 0.001)
        #expect(abs(result[3] - 6.0) < 0.001)
    }

    @Test("Linear fill extrapolates leading and trailing nils")
    func linearFillExtrapolation() {
        let result = Interpolation.linearFill([nil, nil, 10.0, 20.0, nil])
        #expect(abs(result[0] - 10.0) < 0.001) // Leading = first known
        #expect(abs(result[4] - 20.0) < 0.001) // Trailing = last known
    }

    @Test("Linear fill with no nils returns original values")
    func linearFillComplete() {
        let result = Interpolation.linearFill([1.0, 2.0, 3.0])
        #expect(result == [1.0, 2.0, 3.0])
    }

    // MARK: - Cubic Spline

    @Test("Cubic spline returns nil for fewer than 3 points")
    func cubicTooFewPoints() {
        #expect(Interpolation.cubicSpline(at: 0.5, points: [(x: 0, y: 0), (x: 1, y: 1)]) == nil)
    }

    @Test("Cubic spline returns nil for out of range x")
    func cubicOutOfRange() {
        let points: [(x: Double, y: Double)] = [(0, 0), (1, 1), (2, 4)]
        #expect(Interpolation.cubicSpline(at: -1.0, points: points) == nil)
        #expect(Interpolation.cubicSpline(at: 3.0, points: points) == nil)
    }

    @Test("Cubic spline passes through known points")
    func cubicPassesThrough() {
        let points: [(x: Double, y: Double)] = [(0, 0), (1, 1), (2, 4), (3, 9)]
        for point in points {
            let result = Interpolation.cubicSpline(at: point.x, points: points)!
            #expect(abs(result - point.y) < 0.01)
        }
    }

    @Test("Cubic spline is smoother than linear for curved data")
    func cubicSmoothness() {
        // Quadratic data: y = x²
        let points: [(x: Double, y: Double)] = [(0, 0), (1, 1), (2, 4), (3, 9), (4, 16)]
        let cubicAt1_5 = Interpolation.cubicSpline(at: 1.5, points: points)!
        let linearAt1_5 = Interpolation.linear(at: 1.5, points: points)!

        // Cubic should be closer to true value (1.5² = 2.25)
        let cubicError = abs(cubicAt1_5 - 2.25)
        let linearError = abs(linearAt1_5 - 2.25)
        #expect(cubicError <= linearError)
    }

}
