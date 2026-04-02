//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

// MARK: - InsightType

/// Categorizes the kind of statistical insight.
enum InsightType: String, Sendable, Equatable, CaseIterable {

    /// A trend detected over time (e.g. resting HR decreasing).
    case trend

    /// A correlation between two metrics (e.g. HRV vs sleep).
    case correlation

    /// An anomalous data point (e.g. unusually high step count).
    case anomaly

    /// A week-over-week comparison (e.g. steps up 12% vs last week).
    case comparison

    var title: String {
        switch self {
        case .trend:       "Trends"
        case .correlation: "Correlations"
        case .anomaly:     "Anomalies"
        case .comparison:  "Comparisons"
        }
    }

    var image: String {
        switch self {
        case .trend:       "chart.line.uptrend.xyaxis"
        case .correlation: "link"
        case .anomaly:     "exclamationmark.triangle"
        case .comparison:  "arrow.left.arrow.right"
        }
    }

}

// MARK: - InsightPriority

/// Determines the visual prominence and sort order of an insight.
enum InsightPriority: Int, Sendable, Equatable, Comparable {

    case low = 0
    case medium = 1
    case high = 2

    static func < (lhs: InsightPriority, rhs: InsightPriority) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

}

// MARK: - Insight

/// A single statistical insight generated from health data analysis.
struct Insight: Identifiable, Sendable, Equatable {

    /// Unique identifier.
    let id: UUID

    /// The category of this insight.
    let type: InsightType

    /// Short headline (e.g. "Resting heart rate is trending down").
    let title: String

    /// Detailed explanation with numbers (e.g. "Decreased by 2.1 BPM over the past 30 days").
    let description: String

    /// When this insight was generated.
    let date: Date

    /// Determines sort order — higher priority insights appear first.
    let priority: InsightPriority

    init(
        type: InsightType,
        title: String,
        description: String,
        date: Date = .now,
        priority: InsightPriority = .medium
    ) {
        self.id          = UUID()
        self.type        = type
        self.title       = title
        self.description = description
        self.date        = date
        self.priority    = priority
    }

}
