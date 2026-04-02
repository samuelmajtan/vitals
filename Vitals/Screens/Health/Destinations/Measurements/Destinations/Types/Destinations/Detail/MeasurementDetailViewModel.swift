//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import FactoryKit
import AnalysisKit

// MARK: - Protocol

@MainActor
protocol MeasurementDetailViewModelProtocol: AnyObject, Observable {

    // MARK: - Properties

    var state: FetchState<String> { get }
    var error: AppError? { get }
    var context: MeasurementTypesDestinations.Context { get }

    var timeRange: TimeRange { get set }
    var sampleData: [SampleData] { get }

    /// Dynamic summary computed from fetched data.
    var summaryValue: Double? { get }

    /// Descriptive statistics for the current data.
    var statistics: DescriptiveStatisticsResult? { get }

    /// Trend analysis for the current data.
    var trend: LinearRegressionResult? { get }

    /// The chart bar unit adapted to the selected time range.
    var adaptiveBarUnit: Calendar.Component { get }

    // MARK: - Methods

    func fetchSamples() async

}

// MARK: - Implementation

@MainActor
@Observable final class MeasurementDetailViewModel: MeasurementDetailViewModelProtocol {

    // MARK: - Services

    @ObservationIgnored
    @Injected(\.healthService)
    private var healthService: HealthServiceProtocol

    @ObservationIgnored
    @Injected(\.analysisService)
    private var analysisService: AnalysisServiceProtocol

    // MARK: - Properties

    private(set) var state: FetchState<String> = .idle
    private(set) var error: AppError?
    private(set) var context: MeasurementTypesDestinations.Context

    var timeRange: TimeRange = .lastWeek
    private(set) var sampleData: [SampleData] = []
    private(set) var summaryValue: Double?
    private(set) var statistics: DescriptiveStatisticsResult?
    private(set) var trend: LinearRegressionResult?

    // MARK: - Lifecycle

    init(
        state: FetchState<String> = .idle,
        error: AppError? = nil,
        _ context: MeasurementTypesDestinations.Context
    ) {
        self.state = state
        self.error = error
        self.context = context
    }

    // MARK: - Computed

    var adaptiveBarUnit: Calendar.Component {
        switch timeRange {
        case .lastHour:  .minute
        case .lastDay:   .hour
        case .lastWeek:  .day
        case .lastMonth: .day
        case .lastYear:  .month
        }
    }

}

// MARK: - Fetch

extension MeasurementDetailViewModel {

    func fetchSamples() async {
        state = .loading
        let sampleType = context.sample.type
        let interval = timeRange.dateInterval

        // Fetch all concurrently
        async let dataResult = healthService.fetchSampleData(for: sampleType, in: interval, limit: nil)
        async let statsResult = analysisService.descriptiveStatistics(for: sampleType, in: interval)
        async let trendResult = analysisService.trend(for: sampleType, in: interval)

        let rawData = ((try? await dataResult) ?? []).sorted { $0.date < $1.date }
        statistics = try? await statsResult
        trend = try? await trendResult

        // Aggregate data for chart display
        let chartStyle = sampleType.config.chartStyle
        sampleData = aggregateForChart(rawData, style: chartStyle)

        // Compute dynamic summary
        summaryValue = computeSummary(rawData, label: sampleType.config.summaryLabel)

        state = .success("Loaded")
    }

}

// MARK: - Aggregation

private extension MeasurementDetailViewModel {

    /// Aggregates raw samples into chart-ready data based on the chart style.
    func aggregateForChart(_ data: [SampleData], style: ChartStyle) -> [SampleData] {
        guard !data.isEmpty else { return [] }

        switch style {
        case .bar:
            // Cumulative types: sum per time bucket
            return aggregateByBucket(data, operation: .sum)

        case .rangeBar:
            // Discrete types: compute min/max per time bucket
            return aggregateByBucket(data, operation: .range)

        case .line, .interpolatedLine, .point:
            // For longer ranges, downsample by averaging per bucket
            if timeRange == .lastMonth || timeRange == .lastYear {
                return aggregateByBucket(data, operation: .average)
            }
            return data
        }
    }

    enum AggregationOperation {
        case sum
        case average
        case range
    }

    func aggregateByBucket(_ data: [SampleData], operation: AggregationOperation) -> [SampleData] {
        let calendar = Calendar.current

        // Group by time bucket
        var buckets: [Date: [Double]] = [:]

        for sample in data {
            let bucketDate = startOfBucket(for: sample.date, calendar: calendar)
            buckets[bucketDate, default: []].append(sample.value)
        }

        return buckets.keys.sorted().compactMap { date in
            guard let values = buckets[date], !values.isEmpty else { return nil }

            switch operation {
            case .sum:
                let total = values.reduce(0, +)
                return SampleData(date: date, value: total)

            case .average:
                let avg = values.reduce(0, +) / Double(values.count)
                return SampleData(date: date, value: avg)

            case .range:
                let avg = values.reduce(0, +) / Double(values.count)
                let min = values.min() ?? avg
                let max = values.max() ?? avg
                return SampleData(date: date, value: avg, min: min, max: max)
            }
        }
    }

    func startOfBucket(for date: Date, calendar: Calendar) -> Date {
        switch adaptiveBarUnit {
        case .minute:
            // Round to nearest 5 minutes
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            let roundedMinute = (components.minute ?? 0) / 5 * 5
            return calendar.date(from: DateComponents(
                year: components.year, month: components.month, day: components.day,
                hour: components.hour, minute: roundedMinute
            )) ?? date

        case .hour:
            return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: date)) ?? date

        case .day:
            return calendar.startOfDay(for: date)

        case .month:
            return calendar.date(from: calendar.dateComponents([.year, .month], from: date)) ?? date

        default:
            return calendar.startOfDay(for: date)
        }
    }

    /// Computes a dynamic summary value from fetched data.
    func computeSummary(_ data: [SampleData], label: SummaryLabel) -> Double? {
        guard !data.isEmpty else { return nil }
        let values = data.map(\.value)

        switch label {
        case .total:
            return values.reduce(0, +)
        case .average:
            return values.reduce(0, +) / Double(values.count)
        case .latest:
            return data.last?.value
        case .range:
            guard let min = values.min(), let max = values.max() else { return nil }
            return (min + max) / 2.0
        }
    }

}
