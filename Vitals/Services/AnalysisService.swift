//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import FactoryKit
import AnalysisKit

// MARK: - Protocol

protocol AnalysisServiceProtocol: AnyObject {

    // MARK: - Methods

    /// Computes descriptive statistics for a sample type over a date interval.
    func descriptiveStatistics(
        for type: AnySampleType,
        in interval: DateInterval
    ) async throws -> DescriptiveStatisticsResult?

    /// Computes linear regression trend for a sample type over a date interval.
    func trend(
        for type: AnySampleType,
        in interval: DateInterval
    ) async throws -> LinearRegressionResult?

    /// Computes Pearson correlation between two sample types over a date interval.
    /// Data is aligned by calendar day (daily averages for matching days).
    func correlation(
        between typeA: AnySampleType,
        and typeB: AnySampleType,
        in interval: DateInterval
    ) async throws -> CorrelationResult?

    /// Detects anomalies in a sample type over a date interval using z-score thresholding.
    func anomalies(
        for type: AnySampleType,
        in interval: DateInterval,
        threshold: Double
    ) async throws -> AnomalyDetectionResult?

    /// Computes simple moving average for a sample type over a date interval.
    func movingAverage(
        for type: AnySampleType,
        in interval: DateInterval,
        windowSize: Int
    ) async throws -> [Double?]?

}

// MARK: - Default Parameters

extension AnalysisServiceProtocol {

    func anomalies(
        for type: AnySampleType,
        in interval: DateInterval,
        threshold: Double = 2.0
    ) async throws -> AnomalyDetectionResult? {
        try await anomalies(for: type, in: interval, threshold: threshold)
    }

    func movingAverage(
        for type: AnySampleType,
        in interval: DateInterval,
        windowSize: Int = 7
    ) async throws -> [Double?]? {
        try await movingAverage(for: type, in: interval, windowSize: windowSize)
    }

}

// MARK: - Implementation

final class AnalysisService: AnalysisServiceProtocol {

    // MARK: - Services

    @Injected(\.healthService)
    private var healthService: HealthServiceProtocol

    // MARK: - Methods

    func descriptiveStatistics(
        for type: AnySampleType,
        in interval: DateInterval
    ) async throws -> DescriptiveStatisticsResult? {
        let values = try await fetchValues(for: type, in: interval)
        guard !values.isEmpty else { return nil }
        return DescriptiveStatistics.compute(values)
    }

    func trend(
        for type: AnySampleType,
        in interval: DateInterval
    ) async throws -> LinearRegressionResult? {
        let sampleData = try await fetchSampleData(for: type, in: interval)
        guard sampleData.count >= 2 else { return nil }

        // Use time-based x-values (days since start) for meaningful slope
        let startDate = sampleData[0].date
        let points: [(x: Double, y: Double)] = sampleData.map { data in
            let daysSinceStart = data.date.timeIntervalSince(startDate) / 86400
            return (x: daysSinceStart, y: data.value)
        }

        return LinearRegression.fit(points)
    }

    func correlation(
        between typeA: AnySampleType,
        and typeB: AnySampleType,
        in interval: DateInterval
    ) async throws -> CorrelationResult? {
        // Fetch both datasets concurrently
        async let dataA = fetchSampleData(for: typeA, in: interval)
        async let dataB = fetchSampleData(for: typeB, in: interval)

        let (samplesA, samplesB) = try await (dataA, dataB)

        // Align by calendar day — compute daily averages and pair matching days
        let (alignedA, alignedB) = alignByDay(samplesA, samplesB)

        guard alignedA.count >= 3 else { return nil }

        return Correlation.pearson(alignedA, alignedB)
    }

    func anomalies(
        for type: AnySampleType,
        in interval: DateInterval,
        threshold: Double
    ) async throws -> AnomalyDetectionResult? {
        let values = try await fetchValues(for: type, in: interval)
        guard values.count >= 3 else { return nil }
        return AnomalyDetection.detect(values, threshold: threshold)
    }

    func movingAverage(
        for type: AnySampleType,
        in interval: DateInterval,
        windowSize: Int
    ) async throws -> [Double?]? {
        let values = try await fetchValues(for: type, in: interval)
        guard !values.isEmpty else { return nil }
        return MovingAverage.sma(values, windowSize: windowSize)
    }

}

// MARK: - Private

private extension AnalysisService {

    /// Fetches sample data and extracts values as a `[Double]` array sorted chronologically.
    func fetchValues(for type: AnySampleType, in interval: DateInterval) async throws -> [Double] {
        try await fetchSampleData(for: type, in: interval).map(\.value)
    }

    /// Fetches sample data sorted chronologically.
    func fetchSampleData(for type: AnySampleType, in interval: DateInterval) async throws -> [SampleData] {
        try await healthService
            .fetchSampleData(for: type, in: interval, limit: nil)
            .sorted { $0.date < $1.date }
    }

    /// Aligns two time series by calendar day. Groups each series by day,
    /// computes daily averages, and returns paired values for matching days only.
    func alignByDay(_ samplesA: [SampleData], _ samplesB: [SampleData]) -> ([Double], [Double]) {
        let calendar = Calendar.current

        let dailyA = groupByDay(samplesA, calendar: calendar)
        let dailyB = groupByDay(samplesB, calendar: calendar)

        // Find common days
        let commonDays = Set(dailyA.keys).intersection(Set(dailyB.keys)).sorted()

        let alignedA = commonDays.compactMap { dailyA[$0] }
        let alignedB = commonDays.compactMap { dailyB[$0] }

        return (alignedA, alignedB)
    }

    /// Groups sample data by calendar day and computes daily averages.
    func groupByDay(_ samples: [SampleData], calendar: Calendar) -> [Date: Double] {
        var groups: [Date: [Double]] = [:]

        for sample in samples {
            let day = calendar.startOfDay(for: sample.date)
            groups[day, default: []].append(sample.value)
        }

        return groups.mapValues { values in
            values.reduce(0, +) / Double(values.count)
        }
    }

}

// MARK: - Factory

extension Container {

    var analysisService: Factory<AnalysisServiceProtocol> {
        self { AnalysisService() }
            .singleton
    }

}
