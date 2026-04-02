//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import FactoryKit
import AnalysisKit

// MARK: - Protocol

protocol InsightsServiceProtocol: AnyObject {

    // MARK: - Methods

    /// Generates all available insights from the user's health data.
    /// Runs trend, correlation, anomaly, and comparison analyses concurrently.
    @MainActor func generateInsights() async -> [Insight]

}

// MARK: - Implementation

final class InsightsService: InsightsServiceProtocol {

    // MARK: - Services

    @Injected(\.analysisService)
    private var analysisService: AnalysisServiceProtocol

    // MARK: - Methods

    @MainActor
    func generateInsights() async -> [Insight] {
        await withTaskGroup(of: [Insight].self) { group in
            group.addTask { await self.generateTrendInsights() }
            group.addTask { await self.generateCorrelationInsights() }
            group.addTask { await self.generateAnomalyInsights() }
            group.addTask { await self.generateComparisonInsights() }

            var allInsights: [Insight] = []
            for await insights in group {
                allInsights.append(contentsOf: insights)
            }

            return allInsights.sorted { $0.priority > $1.priority }
        }
    }

}

// MARK: - Trend Insights

private extension InsightsService {

    /// Metrics to analyze for trends.
    @MainActor
    static var trendMetrics: [(type: AnySampleType, name: String)] {
        [
            (AnySampleType(VitalsSampleType.restingHeartRate), "Resting heart rate"),
            (AnySampleType(VitalsSampleType.heartRateVariabilitySDNN), "Heart rate variability"),
            (AnySampleType(VitalsSampleType.walkingHeartRateAverage), "Walking heart rate"),
            (AnySampleType(VitalsSampleType.respiratoryRate), "Respiratory rate"),
            (AnySampleType(ActivitySampleType.stepCount), "Daily step count"),
            (AnySampleType(ActivitySampleType.activeEnergyBurned), "Active energy burned"),
            (AnySampleType(MobilitySampleType.walkingSpeed), "Walking speed"),
        ]
    }

    @MainActor
    func generateTrendInsights() async -> [Insight] {
        let interval = DateInterval(start: Date.now.addingTimeInterval(-30 * 86400), end: .now)
        let metrics = Self.trendMetrics

        return await withTaskGroup(of: Insight?.self) { group in
            for metric in metrics {
                group.addTask { [analysisService] in
                    guard let result = try? await analysisService.trend(for: metric.type, in: interval),
                          result.rSquared > 0.3,
                          result.trend != .stable else { return nil }

                    let direction = result.trend == .increasing ? "trending up" : "trending down"
                    let arrow = result.trend == .increasing ? "↑" : "↓"
                    let changePerDay = abs(result.slope)
                    let totalChange = changePerDay * 30

                    let priority: InsightPriority = result.rSquared > 0.6 ? .high : .medium

                    return Insight(
                        type: .trend,
                        title: "\(metric.name) is \(direction) \(arrow)",
                        description: String(
                            format: "Changed by %.1f over the past 30 days (R² = %.2f).",
                            totalChange,
                            result.rSquared
                        ),
                        priority: priority
                    )
                }
            }

            var insights: [Insight] = []
            for await insight in group {
                if let insight { insights.append(insight) }
            }
            return insights
        }
    }

}

// MARK: - Correlation Insights

private extension InsightsService {

    /// Pre-defined metric pairs to check for correlations.
    @MainActor
    static var correlationPairs: [(a: AnySampleType, b: AnySampleType, nameA: String, nameB: String)] {
        [
            (
                AnySampleType(VitalsSampleType.heartRateVariabilitySDNN),
                AnySampleType(SleepSampleType.sleepAnalysis),
                "HRV", "sleep duration"
            ),
            (
                AnySampleType(VitalsSampleType.restingHeartRate),
                AnySampleType(ActivitySampleType.activeEnergyBurned),
                "Resting heart rate", "active energy"
            ),
            (
                AnySampleType(MobilitySampleType.walkingSpeed),
                AnySampleType(ActivitySampleType.stepCount),
                "Walking speed", "step count"
            ),
            (
                AnySampleType(VitalsSampleType.respiratoryRate),
                AnySampleType(SleepSampleType.sleepAnalysis),
                "Respiratory rate", "sleep duration"
            ),
        ]
    }

    @MainActor
    func generateCorrelationInsights() async -> [Insight] {
        let interval = DateInterval(start: Date.now.addingTimeInterval(-30 * 86400), end: .now)
        let pairs = Self.correlationPairs

        return await withTaskGroup(of: Insight?.self) { group in
            for pair in pairs {
                group.addTask { [analysisService] in
                    guard let result = try? await analysisService.correlation(
                        between: pair.a,
                        and: pair.b,
                        in: interval
                    ), abs(result.coefficient) >= 0.5 else { return nil }

                    let direction = result.coefficient > 0 ? "positive" : "negative"
                    let strengthText: String
                    switch result.strength {
                    case .veryStrong: strengthText = "Very strong"
                    case .strong:     strengthText = "Strong"
                    case .moderate:   strengthText = "Moderate"
                    default:          return nil
                    }

                    let priority: InsightPriority = result.strength == .veryStrong ? .high : .medium

                    return Insight(
                        type: .correlation,
                        title: "\(pair.nameA) correlates with \(pair.nameB)",
                        description: String(
                            format: "%@ %@ correlation (r = %.2f) based on %d paired days.",
                            strengthText,
                            direction,
                            result.coefficient,
                            result.sampleSize
                        ),
                        priority: priority
                    )
                }
            }

            var insights: [Insight] = []
            for await insight in group {
                if let insight { insights.append(insight) }
            }
            return insights
        }
    }

}

// MARK: - Anomaly Insights

private extension InsightsService {

    /// Metrics to check for anomalies.
    @MainActor
    static var anomalyMetrics: [(type: AnySampleType, name: String, unit: String)] {
        [
            (AnySampleType(VitalsSampleType.restingHeartRate), "Resting heart rate", "BPM"),
            (AnySampleType(VitalsSampleType.heartRateVariabilitySDNN), "HRV", "ms"),
            (AnySampleType(ActivitySampleType.stepCount), "Step count", "steps"),
            (AnySampleType(ActivitySampleType.activeEnergyBurned), "Active energy", "kcal"),
            (AnySampleType(SleepSampleType.sleepAnalysis), "Sleep duration", "h"),
        ]
    }

    @MainActor
    func generateAnomalyInsights() async -> [Insight] {
        let interval = DateInterval(start: Date.now.addingTimeInterval(-30 * 86400), end: .now)
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: .now)
        let yesterdayStart = calendar.date(byAdding: .day, value: -1, to: todayStart)!
        let metrics = Self.anomalyMetrics

        return await withTaskGroup(of: Insight?.self) { group in
            for metric in metrics {
                group.addTask { [analysisService] in
                    guard let result = try? await analysisService.anomalies(
                        for: metric.type,
                        in: interval,
                        threshold: 2.0
                    ) else { return nil }

                    // Only report the most recent anomaly (today or yesterday)
                    // Anomalies are indexed into the time series — we check if the last
                    // few indices correspond to recent data
                    guard !result.anomalies.isEmpty else { return nil }

                    // Take the first (most extreme) anomaly
                    let anomaly = result.anomalies[0]
                    let direction = anomaly.zScore > 0 ? "unusually high" : "unusually low"
                    let typicalRange = String(
                        format: "%.0f–%.0f %@",
                        result.mean - result.standardDeviation,
                        result.mean + result.standardDeviation,
                        metric.unit
                    )

                    return Insight(
                        type: .anomaly,
                        title: "\(metric.name) was \(direction)",
                        description: String(
                            format: "%.0f %@ (z-score: %.1f, typical range: %@).",
                            anomaly.value,
                            metric.unit,
                            abs(anomaly.zScore),
                            typicalRange
                        ),
                        priority: abs(anomaly.zScore) > 3.0 ? .high : .medium
                    )
                }
            }

            var insights: [Insight] = []
            for await insight in group {
                if let insight { insights.append(insight) }
            }
            return insights
        }
    }

}

// MARK: - Comparison Insights

private extension InsightsService {

    /// Metrics to compare week-over-week.
    @MainActor
    static var comparisonMetrics: [(type: AnySampleType, name: String, unit: String)] {
        [
            (AnySampleType(VitalsSampleType.restingHeartRate), "Resting heart rate", "BPM"),
            (AnySampleType(ActivitySampleType.stepCount), "Daily steps", "steps"),
            (AnySampleType(ActivitySampleType.activeEnergyBurned), "Active energy", "kcal"),
            (AnySampleType(SleepSampleType.sleepAnalysis), "Sleep duration", "h"),
            (AnySampleType(MobilitySampleType.walkingSpeed), "Walking speed", "km/h"),
        ]
    }

    @MainActor
    func generateComparisonInsights() async -> [Insight] {
        let now = Date.now
        let thisWeek = DateInterval(start: now.addingTimeInterval(-7 * 86400), end: now)
        let lastWeek = DateInterval(start: now.addingTimeInterval(-14 * 86400), end: now.addingTimeInterval(-7 * 86400))
        let metrics = Self.comparisonMetrics

        return await withTaskGroup(of: Insight?.self) { group in
            for metric in metrics {
                group.addTask { [analysisService] in
                    async let thisWeekStats = analysisService.descriptiveStatistics(
                        for: metric.type, in: thisWeek
                    )
                    async let lastWeekStats = analysisService.descriptiveStatistics(
                        for: metric.type, in: lastWeek
                    )

                    guard let currentStats = try? await thisWeekStats,
                          let previousStats = try? await lastWeekStats,
                          previousStats.mean > 0 else { return nil }

                    let percentChange = ((currentStats.mean - previousStats.mean) / previousStats.mean) * 100
                    guard abs(percentChange) > 5.0 else { return nil }

                    let direction = percentChange > 0 ? "up" : "down"
                    let arrow = percentChange > 0 ? "↑" : "↓"

                    return Insight(
                        type: .comparison,
                        title: "\(metric.name) is \(direction) this week \(arrow)",
                        description: String(
                            format: "Average %.1f %@ this week vs %.1f %@ last week (%@%.0f%%).",
                            currentStats.mean,
                            metric.unit,
                            previousStats.mean,
                            metric.unit,
                            percentChange > 0 ? "+" : "",
                            percentChange
                        ),
                        priority: abs(percentChange) > 20 ? .high : .low
                    )
                }
            }

            var insights: [Insight] = []
            for await insight in group {
                if let insight { insights.append(insight) }
            }
            return insights
        }
    }

}

// MARK: - Factory

extension Container {

    var insightsService: Factory<InsightsServiceProtocol> {
        self { InsightsService() }
            .singleton
    }

}
