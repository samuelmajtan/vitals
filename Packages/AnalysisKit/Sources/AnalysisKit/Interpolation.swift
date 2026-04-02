//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

// MARK: - Interpolation

/// Provides interpolation methods for filling gaps in health data time series.
public enum Interpolation {

    // MARK: - Linear

    /// Performs linear interpolation at a given x-value between known data points.
    /// - Parameters:
    ///   - x: The x-value to interpolate at.
    ///   - points: Known (x, y) data points. Must have at least 2 points.
    /// - Returns: The interpolated y-value, or `nil` if fewer than 2 points or x is out of range.
    public static func linear(at x: Double, points: [(x: Double, y: Double)]) -> Double? {
        guard points.count >= 2 else { return nil }

        let sorted = points.sorted { $0.x < $1.x }

        // Out of range
        guard x >= sorted.first!.x, x <= sorted.last!.x else { return nil }

        // Find the surrounding interval
        for i in 0..<sorted.count - 1 {
            if x >= sorted[i].x && x <= sorted[i + 1].x {
                let x0 = sorted[i].x
                let x1 = sorted[i + 1].x
                let y0 = sorted[i].y
                let y1 = sorted[i + 1].y

                if x0 == x1 { return y0 }

                let t = (x - x0) / (x1 - x0)
                return y0 + t * (y1 - y0)
            }
        }

        return nil
    }

    /// Fills `nil` gaps in a series using linear interpolation between known values.
    ///
    /// Leading and trailing `nil` values are filled using the nearest known value (extrapolation).
    ///
    /// - Parameter values: Array of optional doubles where `nil` represents missing data.
    /// - Returns: Array with all gaps filled, or empty array if no non-nil values exist.
    public static func linearFill(_ values: [Double?]) -> [Double] {
        guard !values.isEmpty else { return [] }

        // Collect known (index, value) pairs
        let known: [(x: Double, y: Double)] = values.enumerated().compactMap { index, value in
            guard let value else { return nil }
            return (x: Double(index), y: value)
        }

        guard !known.isEmpty else { return [] }
        guard known.count >= 2 else {
            // Only one known value — fill everything with it
            return [Double](repeating: known[0].y, count: values.count)
        }

        var result = [Double](repeating: 0, count: values.count)

        for i in values.indices {
            if let value = values[i] {
                result[i] = value
            } else {
                let x = Double(i)
                if x < known.first!.x {
                    result[i] = known.first!.y
                } else if x > known.last!.x {
                    result[i] = known.last!.y
                } else {
                    result[i] = linear(at: x, points: known) ?? 0
                }
            }
        }

        return result
    }

    // MARK: - Cubic Spline

    /// Performs natural cubic spline interpolation at a given x-value.
    /// - Parameters:
    ///   - x: The x-value to interpolate at.
    ///   - points: Known (x, y) data points. Must have at least 3 points.
    /// - Returns: The interpolated y-value, or `nil` if fewer than 3 points or x is out of range.
    public static func cubicSpline(at x: Double, points: [(x: Double, y: Double)]) -> Double? {
        guard points.count >= 3 else { return nil }

        let sorted = points.sorted { $0.x < $1.x }
        let n = sorted.count

        guard x >= sorted.first!.x, x <= sorted.last!.x else { return nil }

        // Compute spline coefficients using Thomas algorithm
        let coefficients = computeSplineCoefficients(sorted)

        // Find the interval containing x
        var k = 0
        for i in 0..<n - 1 {
            if x >= sorted[i].x && x <= sorted[i + 1].x {
                k = i
                break
            }
        }

        let dx = x - sorted[k].x
        let a = coefficients.a[k]
        let b = coefficients.b[k]
        let c = coefficients.c[k]
        let d = coefficients.d[k]

        return a + b * dx + c * dx * dx + d * dx * dx * dx
    }

}

// MARK: - Private

private extension Interpolation {

    struct SplineCoefficients {
        let a: [Double]
        let b: [Double]
        let c: [Double]
        let d: [Double]
    }

    /// Computes natural cubic spline coefficients using the Thomas algorithm.
    static func computeSplineCoefficients(_ points: [(x: Double, y: Double)]) -> SplineCoefficients {
        let n = points.count
        let nm1 = n - 1

        // Step sizes and divided differences
        var h = [Double](repeating: 0, count: nm1)
        var delta = [Double](repeating: 0, count: nm1)

        for i in 0..<nm1 {
            h[i] = points[i + 1].x - points[i].x
            delta[i] = (points[i + 1].y - points[i].y) / h[i]
        }

        // Solve tridiagonal system for second derivatives (natural BC: s[0] = s[n-1] = 0)
        var s = [Double](repeating: 0, count: n)

        if n > 2 {
            // Set up tridiagonal system
            let m = n - 2
            var lower = [Double](repeating: 0, count: m)
            var diag = [Double](repeating: 0, count: m)
            var upper = [Double](repeating: 0, count: m)
            var rhs = [Double](repeating: 0, count: m)

            for i in 0..<m {
                let idx = i + 1
                if i > 0 { lower[i] = h[idx - 1] }
                diag[i] = 2.0 * (h[idx - 1] + h[idx])
                if i < m - 1 { upper[i] = h[idx] }
                rhs[i] = 6.0 * (delta[idx] - delta[idx - 1])
            }

            // Thomas algorithm (forward elimination)
            for i in 1..<m {
                let factor = lower[i] / diag[i - 1]
                diag[i] -= factor * upper[i - 1]
                rhs[i] -= factor * rhs[i - 1]
            }

            // Back substitution
            var solution = [Double](repeating: 0, count: m)
            solution[m - 1] = rhs[m - 1] / diag[m - 1]
            for i in stride(from: m - 2, through: 0, by: -1) {
                solution[i] = (rhs[i] - upper[i] * solution[i + 1]) / diag[i]
            }

            for i in 0..<m {
                s[i + 1] = solution[i]
            }
        }

        // Compute polynomial coefficients for each interval
        var a = [Double](repeating: 0, count: nm1)
        var b = [Double](repeating: 0, count: nm1)
        var c = [Double](repeating: 0, count: nm1)
        var d = [Double](repeating: 0, count: nm1)

        for i in 0..<nm1 {
            a[i] = points[i].y
            c[i] = s[i] / 2.0
            d[i] = (s[i + 1] - s[i]) / (6.0 * h[i])
            b[i] = delta[i] - h[i] * (2.0 * s[i] + s[i + 1]) / 6.0
        }

        return SplineCoefficients(a: a, b: b, c: c, d: d)
    }

}
