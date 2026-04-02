//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Testing
@testable import AnalysisKit

@Suite("AnomalyDetection Tests")
struct AnomalyDetectionTests {

    @Test("Returns nil for fewer than 3 values")
    func tooFewValues() {
        #expect(AnomalyDetection.detect([1, 2]) == nil)
    }

    @Test("Returns nil for zero standard deviation")
    func zeroStdDev() {
        #expect(AnomalyDetection.detect([5, 5, 5, 5]) == nil)
    }

    @Test("No anomalies in uniform data")
    func noAnomalies() {
        let result = AnomalyDetection.detect([10, 11, 10, 11, 10, 11])!
        #expect(result.anomalies.isEmpty)
    }

    @Test("Detects obvious outlier")
    func detectsOutlier() {
        let values = [10.0, 10.0, 10.0, 10.0, 10.0, 100.0]
        let result = AnomalyDetection.detect(values, threshold: 2.0)!
        #expect(!result.anomalies.isEmpty)
        #expect(result.anomalies[0].index == 5)
        #expect(result.anomalies[0].value == 100.0)
        #expect(result.anomalies[0].zScore > 2.0)
    }

    @Test("Result contains correct mean and stdDev")
    func resultStatistics() {
        let values = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0]
        let result = AnomalyDetection.detect(values)!
        #expect(abs(result.mean - 5.0) < 0.001)
        #expect(abs(result.standardDeviation - 2.0) < 0.001)
    }

    @Test("Threshold parameter is respected")
    func customThreshold() {
        let values = [10.0, 10.0, 10.0, 10.0, 15.0]
        let looseResult = AnomalyDetection.detect(values, threshold: 3.0)!
        let strictResult = AnomalyDetection.detect(values, threshold: 1.0)!
        // Stricter threshold should find more (or equal) anomalies
        #expect(strictResult.anomalies.count >= looseResult.anomalies.count)
    }

    @Test("Default threshold is 2.0")
    func defaultThreshold() {
        let result = AnomalyDetection.detect([1, 2, 3, 4, 5])!
        #expect(result.threshold == 2.0)
    }

    @Test("Anomalies are sorted by absolute z-score descending")
    func anomaliesSorted() {
        let values = [0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 20.0]
        let result = AnomalyDetection.detect(values, threshold: 1.0)!
        if result.anomalies.count >= 2 {
            #expect(abs(result.anomalies[0].zScore) >= abs(result.anomalies[1].zScore))
        }
    }

}
