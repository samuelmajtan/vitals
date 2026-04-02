//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Testing
@testable import AnalysisKit

@Suite("Correlation Tests")
struct CorrelationTests {

    @Test("Returns nil for arrays with fewer than 3 elements")
    func tooFewElements() {
        #expect(Correlation.pearson([1, 2], [3, 4]) == nil)
        #expect(Correlation.spearman([1], [2]) == nil)
    }

    @Test("Returns nil for arrays of different lengths")
    func differentLengths() {
        #expect(Correlation.pearson([1, 2, 3], [4, 5]) == nil)
    }

    @Test("Perfect positive correlation r = 1.0")
    func perfectPositive() {
        let result = Correlation.pearson([1, 2, 3, 4, 5], [2, 4, 6, 8, 10])!
        #expect(abs(result.coefficient - 1.0) < 0.001)
        #expect(result.strength == .veryStrong)
    }

    @Test("Perfect negative correlation r = -1.0")
    func perfectNegative() {
        let result = Correlation.pearson([1, 2, 3, 4, 5], [10, 8, 6, 4, 2])!
        #expect(abs(result.coefficient - (-1.0)) < 0.001)
        #expect(result.strength == .veryStrong)
    }

    @Test("Zero correlation for uncorrelated data")
    func zeroCorrelation() {
        // Orthogonal-like data
        let result = Correlation.pearson([1, 0, -1, 0], [0, 1, 0, -1])!
        #expect(abs(result.coefficient) < 0.001)
        #expect(result.strength == .negligible)
    }

    @Test("P-value is near zero for perfect correlation")
    func pValuePerfect() {
        let result = Correlation.pearson([1, 2, 3, 4, 5], [2, 4, 6, 8, 10])!
        #expect(result.pValue < 0.01)
    }

    @Test("Spearman equals Pearson for monotonic data")
    func spearmanMonotonic() {
        let x = [1.0, 2.0, 3.0, 4.0, 5.0]
        let y = [2.0, 4.0, 6.0, 8.0, 10.0]
        let pearson = Correlation.pearson(x, y)!
        let spearman = Correlation.spearman(x, y)!
        #expect(abs(pearson.coefficient - spearman.coefficient) < 0.001)
    }

    @Test("Spearman detects monotonic nonlinear relationship")
    func spearmanNonlinear() {
        // Exponential-like: monotonically increasing but not linear
        let x = [1.0, 2.0, 3.0, 4.0, 5.0]
        let y = [1.0, 4.0, 9.0, 16.0, 25.0]
        let spearman = Correlation.spearman(x, y)!
        #expect(abs(spearman.coefficient - 1.0) < 0.001)
    }

    @Test("CorrelationStrength thresholds")
    func strengthThresholds() {
        #expect(CorrelationStrength(coefficient: 0.05) == .negligible)
        #expect(CorrelationStrength(coefficient: 0.2) == .weak)
        #expect(CorrelationStrength(coefficient: 0.4) == .moderate)
        #expect(CorrelationStrength(coefficient: 0.6) == .strong)
        #expect(CorrelationStrength(coefficient: 0.85) == .veryStrong)
        #expect(CorrelationStrength(coefficient: -0.85) == .veryStrong)
    }

    @Test("Sample size is correct")
    func sampleSize() {
        let result = Correlation.pearson([1, 2, 3, 4], [5, 6, 7, 8])!
        #expect(result.sampleSize == 4)
    }

}
