//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

// MARK: - Result

/// Contains all descriptive statistics for a dataset.
public struct DescriptiveStatisticsResult: Sendable, Equatable {

    /// Number of values in the dataset.
    public let count: Int

    /// Arithmetic mean.
    public let mean: Double

    /// Middle value (50th percentile).
    public let median: Double

    /// Most frequently occurring value(s).
    public let mode: [Double]

    /// Population standard deviation (σ).
    public let standardDeviation: Double

    /// Population variance (σ²).
    public let variance: Double

    /// Minimum value.
    public let min: Double

    /// Maximum value.
    public let max: Double

    /// First quartile (25th percentile).
    public let q1: Double

    /// Third quartile (75th percentile).
    public let q3: Double

    /// Interquartile range (Q3 - Q1).
    public let iqr: Double

    /// Skewness — measure of asymmetry. Positive = right tail, negative = left tail.
    public let skewness: Double

    /// Kurtosis — measure of tail heaviness (excess kurtosis, normal = 0).
    public let kurtosis: Double

}

// MARK: - DescriptiveStatistics

/// Provides descriptive statistics computations for arrays of `Double` values.
public enum DescriptiveStatistics {

    // MARK: - Full Computation

    /// Computes all descriptive statistics for the given values.
    /// - Parameter values: The dataset. Must not be empty.
    /// - Returns: A result containing all computed statistics, or `nil` if values is empty.
    public static func compute(_ values: [Double]) -> DescriptiveStatisticsResult? {
        guard !values.isEmpty else { return nil }

        let n = Double(values.count)
        let sorted = values.sorted()

        let mean = values.reduce(0, +) / n
        let median = computeMedian(sorted)
        let mode = computeMode(values)

        let variance = values.reduce(0) { $0 + ($1 - mean) * ($1 - mean) } / n
        let standardDeviation = sqrt(variance)

        let q1 = computePercentile(sorted, p: 0.25)
        let q3 = computePercentile(sorted, p: 0.75)
        let iqr = q3 - q1

        let skewness: Double
        let kurtosis: Double

        if standardDeviation > 0 {
            skewness = values.reduce(0) { $0 + pow(($1 - mean) / standardDeviation, 3) } / n
            kurtosis = values.reduce(0) { $0 + pow(($1 - mean) / standardDeviation, 4) } / n - 3.0
        } else {
            skewness = 0
            kurtosis = 0
        }

        return DescriptiveStatisticsResult(
            count: values.count,
            mean: mean,
            median: median,
            mode: mode,
            standardDeviation: standardDeviation,
            variance: variance,
            min: sorted.first!,
            max: sorted.last!,
            q1: q1,
            q3: q3,
            iqr: iqr,
            skewness: skewness,
            kurtosis: kurtosis
        )
    }

    // MARK: - Convenience

    /// Computes the arithmetic mean.
    public static func mean(_ values: [Double]) -> Double? {
        guard !values.isEmpty else { return nil }
        return values.reduce(0, +) / Double(values.count)
    }

    /// Computes the median (50th percentile).
    public static func median(_ values: [Double]) -> Double? {
        guard !values.isEmpty else { return nil }
        return computeMedian(values.sorted())
    }

    /// Computes the population standard deviation.
    public static func standardDeviation(_ values: [Double]) -> Double? {
        guard !values.isEmpty else { return nil }
        let mean = values.reduce(0, +) / Double(values.count)
        let variance = values.reduce(0) { $0 + ($1 - mean) * ($1 - mean) } / Double(values.count)
        return sqrt(variance)
    }

    /// Computes an arbitrary percentile using linear interpolation.
    /// - Parameters:
    ///   - values: The dataset.
    ///   - p: The percentile to compute (0.0 to 1.0).
    /// - Returns: The interpolated percentile value, or `nil` if values is empty.
    public static func percentile(_ values: [Double], p: Double) -> Double? {
        guard !values.isEmpty else { return nil }
        return computePercentile(values.sorted(), p: p)
    }

}

// MARK: - Private

private extension DescriptiveStatistics {

    /// Computes median from a pre-sorted array.
    static func computeMedian(_ sorted: [Double]) -> Double {
        let n = sorted.count
        if n % 2 == 0 {
            return (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0
        } else {
            return sorted[n / 2]
        }
    }

    /// Computes mode (most frequent values).
    static func computeMode(_ values: [Double]) -> [Double] {
        var frequency: [Double: Int] = [:]
        for value in values {
            frequency[value, default: 0] += 1
        }
        let maxFrequency = frequency.values.max() ?? 0
        guard maxFrequency > 1 else { return [] }
        return frequency
            .filter { $0.value == maxFrequency }
            .map(\.key)
            .sorted()
    }

    /// Computes percentile from a pre-sorted array using linear interpolation.
    static func computePercentile(_ sorted: [Double], p: Double) -> Double {
        let n = Double(sorted.count)
        let rank = p * (n - 1)
        let lowerIndex = Int(floor(rank))
        let upperIndex = Int(ceil(rank))
        let fraction = rank - Double(lowerIndex)

        if lowerIndex == upperIndex {
            return sorted[lowerIndex]
        }
        return sorted[lowerIndex] * (1 - fraction) + sorted[upperIndex] * fraction
    }

}
