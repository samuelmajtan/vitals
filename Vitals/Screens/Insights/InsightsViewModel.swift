//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI
import FactoryKit

// MARK: - Protocol

@MainActor
protocol InsightsViewModelProtocol: AnyObject, Observable {

    // MARK: - Properties

    var state: FetchState<String> { get }
    var error: AppError? { get }
    var insights: [Insight] { get }

    /// Insight types that have at least one insight, in display order.
    var activeTypes: [InsightType] { get }

    // MARK: - Methods

    /// Returns insights for a specific type.
    func insights(for type: InsightType) -> [Insight]

    /// Returns the count of insights for a specific type.
    func count(for type: InsightType) -> Int

    /// Fetches all insights from the service.
    func fetchInsights() async

}

// MARK: - Implementation

@MainActor
@Observable
final class InsightsViewModel: InsightsViewModelProtocol {

    // MARK: - Services

    @ObservationIgnored
    @Injected(\.insightsService)
    private var insightsService: InsightsServiceProtocol

    // MARK: - Properties

    private(set) var state: FetchState<String> = .idle
    private(set) var error: AppError?
    private(set) var insights: [Insight] = []

    /// Display order for insight types.
    private let typeOrder: [InsightType] = [.anomaly, .trend, .correlation, .comparison]

    // MARK: - Lifecycle

    init(state: FetchState<String> = .idle, error: AppError? = nil) {
        self.state = state
        self.error = error
    }

    // MARK: - Computed

    var activeTypes: [InsightType] {
        typeOrder.filter { type in
            insights.contains { $0.type == type }
        }
    }

    // MARK: - Methods

    func insights(for type: InsightType) -> [Insight] {
        insights.filter { $0.type == type }
    }

    func count(for type: InsightType) -> Int {
        insights.count { $0.type == type }
    }

}

// MARK: - Fetch State

extension InsightsViewModel {

    func fetchInsights() async {
        state = .loading
        error = nil

        let results = await insightsService.generateInsights()
        insights = results
        state = .success("Loaded \(results.count) insights")
    }

}
