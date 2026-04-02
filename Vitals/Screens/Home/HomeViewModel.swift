//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import FactoryKit
import SwiftUI
import AnalysisKit

// MARK: - Protocol

@MainActor
protocol HomeViewModelProtocol: AnyObject, Observable {

    // MARK: - Properties

    var state: FetchState<String> { get }
    var error: AppError? { get }
    var metrics: [HomeMetric] { get }
    var recentInsights: [Insight] { get }

    // MARK: - Methods

    func fetchDashboard() async

}

// MARK: - Implementation

@MainActor
@Observable final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Services

    @ObservationIgnored
    @Injected(\.healthService)
    private var healthService: HealthServiceProtocol

    @ObservationIgnored
    @Injected(\.analysisService)
    private var analysisService: AnalysisServiceProtocol

    @ObservationIgnored
    @Injected(\.insightsService)
    private var insightsService: InsightsServiceProtocol

    // MARK: - Properties

    private(set) var state: FetchState<String> = .idle
    private(set) var error: AppError?
    private(set) var metrics: [HomeMetric] = []
    private(set) var recentInsights: [Insight] = []

    // MARK: - Lifecycle

    init(state: FetchState<String> = .idle, error: AppError? = nil) {
        self.state = state
        self.error = error
    }

}

// MARK: - Fetch

extension HomeViewModel {

    func fetchDashboard() async {
        state = .loading
        error = nil

        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchMetrics() }
            group.addTask { await self.fetchInsights() }
        }

        state = .success("Dashboard loaded")
    }

}

// MARK: - Private

private extension HomeViewModel {

    static var dashboardMetrics: [(type: AnySampleType, title: String, image: String, color: Color, unit: String, category: SampleCategory)] {
        [
            (AnySampleType(VitalsSampleType.restingHeartRate), "Resting HR", "heart.fill", .red, "BPM", .vitals),
            (AnySampleType(ActivitySampleType.stepCount), "Steps", "figure.walk", .orange, "steps", .activity),
            (AnySampleType(SleepSampleType.sleepAnalysis), "Sleep", "bed.double.fill", .indigo, "h", .sleep),
            (AnySampleType(ActivitySampleType.activeEnergyBurned), "Energy", "flame.fill", .green, "kcal", .activity),
            (AnySampleType(VitalsSampleType.heartRateVariabilitySDNN), "HRV", "waveform.path.ecg", .teal, "ms", .vitals),
            (AnySampleType(MobilitySampleType.walkingSpeed), "Walk Speed", "figure.walk.motion", .blue, "km/h", .mobility),
        ]
    }

    func fetchMetrics() async {
        let descriptors = Self.dashboardMetrics
        let trendInterval = DateInterval(start: Date.now.addingTimeInterval(-14 * 86400), end: .now)

        let results: [HomeMetric] = await withTaskGroup(of: HomeMetric?.self) { group in
            for descriptor in descriptors {
                group.addTask { [healthService, analysisService] in
                    // Fetch latest sample
                    let sample = try? await healthService.fetchSample(for: descriptor.type)

                    // Fetch 14-day trend
                    let trend = try? await analysisService.trend(for: descriptor.type, in: trendInterval)

                    guard let sample else { return nil }

                    let formatted: String
                    if sample.value >= 1000 {
                        formatted = String(format: "%.0f", sample.value)
                    } else {
                        formatted = sample.value.shortFormatted
                    }

                    return HomeMetric(
                        title: descriptor.title,
                        image: descriptor.image,
                        color: descriptor.color,
                        value: formatted,
                        unit: descriptor.unit,
                        trend: trend?.trend,
                        category: descriptor.category
                    )
                }
            }

            var collected: [HomeMetric] = []
            for await metric in group {
                if let metric { collected.append(metric) }
            }
            return collected
        }

        // Sort to match original order based on descriptor titles
        let orderedTitles = descriptors.map(\.title)
        metrics = results.sorted { a, b in
            (orderedTitles.firstIndex(of: a.title) ?? 0) < (orderedTitles.firstIndex(of: b.title) ?? 0)
        }
    }

    func fetchInsights() async {
        let allInsights = await insightsService.generateInsights()
        recentInsights = Array(allInsights.prefix(3))
    }

}
