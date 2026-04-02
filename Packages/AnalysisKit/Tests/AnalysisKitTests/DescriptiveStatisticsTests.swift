//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Testing
@testable import AnalysisKit

@Suite("DescriptiveStatistics Tests")
struct DescriptiveStatisticsTests {

    @Test("Returns nil for empty array")
    func emptyArray() {
        #expect(DescriptiveStatistics.compute([]) == nil)
        #expect(DescriptiveStatistics.mean([]) == nil)
        #expect(DescriptiveStatistics.median([]) == nil)
        #expect(DescriptiveStatistics.standardDeviation([]) == nil)
        #expect(DescriptiveStatistics.percentile([], p: 0.5) == nil)
    }

    @Test("Single value dataset")
    func singleValue() {
        let result = DescriptiveStatistics.compute([42.0])!
        #expect(result.count == 1)
        #expect(result.mean == 42.0)
        #expect(result.median == 42.0)
        #expect(result.min == 42.0)
        #expect(result.max == 42.0)
        #expect(result.standardDeviation == 0.0)
        #expect(result.variance == 0.0)
    }

    @Test("Mean of [1, 2, 3, 4, 5] = 3.0")
    func meanSimple() {
        let mean = DescriptiveStatistics.mean([1, 2, 3, 4, 5])
        #expect(mean == 3.0)
    }

    @Test("Median of odd count [1, 2, 3, 4, 5] = 3.0")
    func medianOdd() {
        let median = DescriptiveStatistics.median([5, 3, 1, 4, 2])
        #expect(median == 3.0)
    }

    @Test("Median of even count [1, 2, 3, 4] = 2.5")
    func medianEven() {
        let median = DescriptiveStatistics.median([4, 1, 3, 2])
        #expect(median == 2.5)
    }

    @Test("Standard deviation of uniform values = 0")
    func stdDevUniform() {
        let stdDev = DescriptiveStatistics.standardDeviation([5, 5, 5, 5])
        #expect(stdDev == 0.0)
    }

    @Test("Standard deviation of [2, 4, 4, 4, 5, 5, 7, 9] = 2.0")
    func stdDevKnown() {
        let stdDev = DescriptiveStatistics.standardDeviation([2, 4, 4, 4, 5, 5, 7, 9])!
        #expect(abs(stdDev - 2.0) < 0.001)
    }

    @Test("Percentile Q1 and Q3")
    func percentiles() {
        let values = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
        let q1 = DescriptiveStatistics.percentile(values, p: 0.25)!
        let q3 = DescriptiveStatistics.percentile(values, p: 0.75)!
        #expect(abs(q1 - 3.25) < 0.001)
        #expect(abs(q3 - 7.75) < 0.001)
    }

    @Test("Mode detects most frequent values")
    func mode() {
        let result = DescriptiveStatistics.compute([1, 2, 2, 3, 3, 4])!
        #expect(result.mode == [2.0, 3.0])
    }

    @Test("Mode is empty when all values are unique")
    func modeAllUnique() {
        let result = DescriptiveStatistics.compute([1, 2, 3, 4, 5])!
        #expect(result.mode.isEmpty)
    }

    @Test("Full compute returns correct IQR")
    func iqr() {
        let result = DescriptiveStatistics.compute([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])!
        #expect(abs(result.iqr - 4.5) < 0.001)
    }

    @Test("Skewness is near zero for symmetric data")
    func skewnessSymmetric() {
        let result = DescriptiveStatistics.compute([1, 2, 3, 4, 5, 6, 7, 8, 9])!
        #expect(abs(result.skewness) < 0.001)
    }

    @Test("Kurtosis of normal-like data is near zero (excess kurtosis)")
    func kurtosis() {
        // For uniform distribution, excess kurtosis = -1.2
        let result = DescriptiveStatistics.compute([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])!
        #expect(abs(result.kurtosis - (-1.224)) < 0.01)
    }

}
