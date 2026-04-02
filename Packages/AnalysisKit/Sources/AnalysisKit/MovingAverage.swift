//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

// MARK: - MovingAverage

/// Provides moving average computations for smoothing time series data.
public enum MovingAverage {

    /// Computes the Simple Moving Average (SMA).
    ///
    /// Each output value is the mean of the preceding `windowSize` values.
    /// The first `windowSize - 1` positions are `nil` since there is insufficient data.
    ///
    /// - Parameters:
    ///   - values: The input time series.
    ///   - windowSize: The number of values in each window. Must be >= 1 and <= values.count.
    /// - Returns: Array of optional doubles (nil where insufficient data), or `nil` if inputs are invalid.
    public static func sma(_ values: [Double], windowSize: Int) -> [Double?]? {
        guard windowSize >= 1, windowSize <= values.count, !values.isEmpty else { return nil }

        var result = [Double?](repeating: nil, count: values.count)

        // Compute initial window sum
        var windowSum = values[0..<windowSize].reduce(0, +)
        result[windowSize - 1] = windowSum / Double(windowSize)

        // Slide the window
        for i in windowSize..<values.count {
            windowSum += values[i] - values[i - windowSize]
            result[i] = windowSum / Double(windowSize)
        }

        return result
    }

    /// Computes the Exponential Moving Average (EMA).
    ///
    /// Uses smoothing factor α = 2 / (windowSize + 1). The first value is seeded
    /// with the SMA of the first `windowSize` values.
    ///
    /// - Parameters:
    ///   - values: The input time series.
    ///   - windowSize: The window size for the smoothing factor. Must be >= 1 and <= values.count.
    /// - Returns: Array of doubles, or `nil` if inputs are invalid.
    public static func ema(_ values: [Double], windowSize: Int) -> [Double]? {
        guard windowSize >= 1, windowSize <= values.count, !values.isEmpty else { return nil }

        let alpha = 2.0 / (Double(windowSize) + 1.0)
        var result = [Double](repeating: 0, count: values.count)

        // Seed with SMA of first window
        let seed = values[0..<windowSize].reduce(0, +) / Double(windowSize)
        result[0] = seed

        // For values before window is full, still apply EMA from seed
        for i in 1..<values.count {
            result[i] = alpha * values[i] + (1 - alpha) * result[i - 1]
        }

        return result
    }

}
