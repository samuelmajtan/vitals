//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

// MARK: - Trend Direction

/// Describes the direction of a linear trend.
public enum TrendDirection: String, Sendable, Equatable {

    /// Values are increasing over time.
    case increasing

    /// Values are decreasing over time.
    case decreasing

    /// Values are relatively stable (less than 5% change over the dataset).
    case stable

}

// MARK: - Result

/// Contains the result of a linear regression fit.
public struct LinearRegressionResult: Sendable, Equatable {

    /// Slope of the regression line (rate of change per unit x).
    public let slope: Double

    /// Y-intercept of the regression line.
    public let intercept: Double

    /// Coefficient of determination (0.0 to 1.0). Higher = better fit.
    public let rSquared: Double

    /// Interpreted direction of the trend.
    public let trend: TrendDirection

}

// MARK: - LinearRegression

/// Provides simple linear regression analysis.
public enum LinearRegression {

    /// Fits a linear regression to (x, y) data points.
    /// - Parameter points: Array of (x, y) pairs. Must have at least 2 points.
    /// - Returns: Regression result, or `nil` if fewer than 2 points or zero variance in x.
    public static func fit(_ points: [(x: Double, y: Double)]) -> LinearRegressionResult? {
        guard points.count >= 2 else { return nil }

        let n = Double(points.count)
        let meanX = points.reduce(0) { $0 + $1.x } / n
        let meanY = points.reduce(0) { $0 + $1.y } / n

        var sumXY = 0.0
        var sumX2 = 0.0
        var sumY2 = 0.0

        for point in points {
            let dx = point.x - meanX
            let dy = point.y - meanY
            sumXY += dx * dy
            sumX2 += dx * dx
            sumY2 += dy * dy
        }

        guard sumX2 > 0 else { return nil }

        let slope = sumXY / sumX2
        let intercept = meanY - slope * meanX

        // R² = (explained variance) / (total variance)
        let rSquared: Double
        if sumY2 > 0 {
            rSquared = (sumXY * sumXY) / (sumX2 * sumY2)
        } else {
            rSquared = 1.0
        }

        let trend = determineTrend(slope: slope, n: n, meanY: meanY)

        return LinearRegressionResult(
            slope: slope,
            intercept: intercept,
            rSquared: rSquared,
            trend: trend
        )
    }

    /// Fits a linear regression where x is the array index (0, 1, 2, ...).
    /// - Parameter values: The y-values. Must have at least 2 values.
    /// - Returns: Regression result, or `nil` if fewer than 2 values.
    public static func fit(_ values: [Double]) -> LinearRegressionResult? {
        let points = values.enumerated().map { (x: Double($0.offset), y: $0.element) }
        return fit(points)
    }

    /// Predicts the y-value for a given x using a regression result.
    /// - Parameters:
    ///   - x: The x-value to predict for.
    ///   - result: A previously computed regression result.
    /// - Returns: The predicted y-value.
    public static func predict(x: Double, using result: LinearRegressionResult) -> Double {
        result.slope * x + result.intercept
    }

}

// MARK: - Private

private extension LinearRegression {

    /// Determines trend direction based on the relative change over the dataset.
    static func determineTrend(slope: Double, n: Double, meanY: Double) -> TrendDirection {
        guard meanY != 0 else {
            return slope == 0 ? .stable : (slope > 0 ? .increasing : .decreasing)
        }

        // Relative change: slope * n / |mean| represents the percentage change over the dataset
        let relativeChange = abs(slope * n / meanY)

        if relativeChange < 0.05 {
            return .stable
        }
        return slope > 0 ? .increasing : .decreasing
    }

}
