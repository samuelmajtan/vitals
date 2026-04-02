//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

// MARK: - Anomaly

public struct Anomaly: Sendable, Equatable {

    /// The index of the anomalous value in the original array.
    public let index: Int

    /// The anomalous value.
    public let value: Double

    /// The z-score of the anomalous value.
    public let zScore: Double

}

// MARK: - Result

public struct AnomalyDetectionResult: Sendable, Equatable {

    /// Detected anomalies, sorted by absolute z-score (most extreme first).
    public let anomalies: [Anomaly]

    /// Mean of the dataset.
    public let mean: Double

    /// Population standard deviation of the dataset.
    public let standardDeviation: Double

    /// The z-score threshold used for detection.
    public let threshold: Double

}

// MARK: - Anomaly Detection

public enum AnomalyDetection {

    /// Detects anomalies in a dataset using z-score thresholding.
    ///
    /// A value is considered anomalous if its absolute z-score exceeds the threshold.
    ///
    /// - Parameters:
    ///   - values: The dataset. Must have at least 3 values.
    ///   - threshold: The z-score threshold (default: 2.0). Values with |z| > threshold are anomalies.
    /// - Returns: Detection result containing anomalies and dataset statistics, or `nil` if
    ///   fewer than 3 values or zero standard deviation.
    public static func detect(_ values: [Double], threshold: Double = 2.0) -> AnomalyDetectionResult? {
        guard values.count >= 3 else { return nil }

        let n = Double(values.count)
        let mean = values.reduce(0, +) / n
        let variance = values.reduce(0) { $0 + ($1 - mean) * ($1 - mean) } / n
        let standardDeviation = sqrt(variance)

        guard standardDeviation > 0 else { return nil }

        var anomalies: [Anomaly] = []

        for (index, value) in values.enumerated() {
            let zScore = (value - mean) / standardDeviation
            if abs(zScore) > threshold {
                anomalies.append(Anomaly(index: index, value: value, zScore: zScore))
            }
        }

        anomalies.sort { abs($0.zScore) > abs($1.zScore) }

        return AnomalyDetectionResult(
            anomalies: anomalies,
            mean: mean,
            standardDeviation: standardDeviation,
            threshold: threshold
        )
    }

}
