//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

// MARK: - Strength

/// Describes the strength of a correlation coefficient.
public enum CorrelationStrength: String, Sendable, Equatable {

    case negligible
    case weak
    case moderate
    case strong
    case veryStrong

    /// Determines correlation strength from an absolute correlation coefficient.
    public init(coefficient: Double) {
        let abs = Swift.abs(coefficient)
        switch abs {
        case ..<0.1: self = .negligible
        case ..<0.3: self = .weak
        case ..<0.5: self = .moderate
        case ..<0.7: self = .strong
        default: self = .veryStrong
        }
    }

}

// MARK: - Result

/// Contains the result of a correlation computation.
public struct CorrelationResult: Sendable, Equatable {

    /// The correlation coefficient (-1.0 to 1.0).
    public let coefficient: Double

    /// The approximate p-value for testing significance (H0: ρ = 0).
    public let pValue: Double

    /// Number of paired observations.
    public let sampleSize: Int

    /// Interpreted strength of the correlation.
    public let strength: CorrelationStrength

}

// MARK: - Correlation

/// Provides correlation analysis between two datasets.
public enum Correlation {

    /// Computes the Pearson product-moment correlation coefficient.
    /// - Parameters:
    ///   - x: First variable values.
    ///   - y: Second variable values. Must have the same count as `x`.
    /// - Returns: Correlation result, or `nil` if arrays have fewer than 3 elements or different lengths.
    public static func pearson(_ x: [Double], _ y: [Double]) -> CorrelationResult? {
        guard x.count == y.count, x.count >= 3 else { return nil }

        let n = Double(x.count)
        let meanX = x.reduce(0, +) / n
        let meanY = y.reduce(0, +) / n

        var sumXY = 0.0
        var sumX2 = 0.0
        var sumY2 = 0.0

        for i in x.indices {
            let dx = x[i] - meanX
            let dy = y[i] - meanY
            sumXY += dx * dy
            sumX2 += dx * dx
            sumY2 += dy * dy
        }

        guard sumX2 > 0, sumY2 > 0 else { return nil }

        let r = sumXY / sqrt(sumX2 * sumY2)
        let pValue = computePValue(r: r, n: Int(n))

        return CorrelationResult(
            coefficient: r,
            pValue: pValue,
            sampleSize: Int(n),
            strength: CorrelationStrength(coefficient: r)
        )
    }

    /// Computes the Spearman rank correlation coefficient.
    /// Converts values to ranks (ties handled by average rank), then applies Pearson.
    /// - Parameters:
    ///   - x: First variable values.
    ///   - y: Second variable values. Must have the same count as `x`.
    /// - Returns: Correlation result, or `nil` if arrays have fewer than 3 elements or different lengths.
    public static func spearman(_ x: [Double], _ y: [Double]) -> CorrelationResult? {
        guard x.count == y.count, x.count >= 3 else { return nil }

        let ranksX = computeRanks(x)
        let ranksY = computeRanks(y)

        return pearson(ranksX, ranksY)
    }

}

// MARK: - Private

private extension Correlation {

    /// Converts values to ranks with average rank for ties.
    static func computeRanks(_ values: [Double]) -> [Double] {
        let indexed = values.enumerated().sorted { $0.element < $1.element }
        var ranks = [Double](repeating: 0, count: values.count)

        var i = 0
        while i < indexed.count {
            var j = i
            while j < indexed.count - 1 && indexed[j + 1].element == indexed[i].element {
                j += 1
            }
            // Average rank for tied values (1-based)
            let averageRank = Double(i + j) / 2.0 + 1.0
            for k in i...j {
                ranks[indexed[k].offset] = averageRank
            }
            i = j + 1
        }

        return ranks
    }

    /// Approximates the two-tailed p-value for a correlation coefficient
    /// using the t-distribution with n-2 degrees of freedom.
    static func computePValue(r: Double, n: Int) -> Double {
        guard n > 2 else { return 1.0 }
        let absR = Swift.abs(r)
        guard absR < 1.0 else { return 0.0 }

        let df = Double(n - 2)
        let t = absR * sqrt(df / (1.0 - absR * absR))

        // Two-tailed p-value using regularized incomplete beta function approximation
        return 2.0 * tDistributionSurvival(t: t, df: df)
    }

    /// Computes the survival function (1 - CDF) of the t-distribution
    /// using Abramowitz & Stegun rational approximation (formula 26.2.17).
    static func tDistributionSurvival(t: Double, df: Double) -> Double {
        let x = df / (df + t * t)

        // Regularized incomplete beta function I_x(a, b) where a = df/2, b = 0.5
        let a = df / 2.0
        let b = 0.5

        let result = regularizedIncompleteBeta(x: x, a: a, b: b)
        return result / 2.0
    }

    /// Computes the regularized incomplete beta function I_x(a, b)
    /// using a continued fraction expansion (Lentz's algorithm).
    static func regularizedIncompleteBeta(x: Double, a: Double, b: Double) -> Double {
        guard x > 0 else { return 0.0 }
        guard x < 1 else { return 1.0 }

        let lnBeta = lgamma(a) + lgamma(b) - lgamma(a + b)
        let prefix = exp(a * log(x) + b * log(1.0 - x) - lnBeta)

        // Use continued fraction (Lentz's method)
        let maxIterations = 200
        let epsilon = 1e-10
        let tiny = 1e-30

        var c = 1.0
        var d = 1.0 / max(1.0 - (a + b) * x / (a + 1.0), tiny)
        var h = d

        for m in 1...maxIterations {
            let mDouble = Double(m)

            let numerator1 = mDouble * (b - mDouble) * x / ((a + 2.0 * mDouble - 1.0) * (a + 2.0 * mDouble))
            d = 1.0 / max(1.0 + numerator1 * d, tiny)
            c = max(1.0 + numerator1 / c, tiny)
            h *= d * c

            let numerator2 = -(a + mDouble) * (a + b + mDouble) * x / ((a + 2.0 * mDouble) * (a + 2.0 * mDouble + 1.0))
            d = 1.0 / max(1.0 + numerator2 * d, tiny)
            c = max(1.0 + numerator2 / c, tiny)
            let delta = d * c
            h *= delta

            if abs(delta - 1.0) < epsilon {
                break
            }
        }

        return prefix * h / a
    }

}
