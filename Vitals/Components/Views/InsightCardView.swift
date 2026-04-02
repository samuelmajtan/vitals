//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct InsightCardView: View {

    // MARK: - Properties

    let insight: Insight

    // MARK: - View

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            priorityStripe
            content
        }
        .background(typeColor.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: Constant.Radius.sm))
        .overlay {
            RoundedRectangle(cornerRadius: Constant.Radius.sm)
                .strokeBorder(typeColor.opacity(0.15), lineWidth: 1)
        }
    }

}

// MARK: - Subviews

private extension InsightCardView {

    var priorityStripe: some View {
        Rectangle()
            .fill(priorityColor)
            .frame(width: 4)
    }

    var content: some View {
        VStack(alignment: .leading, spacing: Constant.Spacing.sm) {
            HStack(alignment: .center, spacing: Constant.Spacing.sm) {
                Image(systemName: insight.type.image)
                    .font(.subheadline.bold())
                    .foregroundStyle(typeColor)

                Text(insight.title)
                    .font(.subheadline.bold())
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Spacer()
            }

            Text(insight.description)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(3)
        }
        .padding(.horizontal, Constant.Spacing.md)
        .padding(.vertical, Constant.Spacing.md)
    }

}

// MARK: - Colors

private extension InsightCardView {

    var typeColor: Color {
        switch insight.type {
        case .anomaly:     .red
        case .trend:       .teal
        case .correlation: .blue
        case .comparison:  .green
        }
    }

    var priorityColor: Color {
        switch insight.priority {
        case .high:   .red
        case .medium: .orange
        case .low:    .secondary
        }
    }

}

// MARK: - Preview

#Preview("High Priority Anomaly") {
    InsightCardView(insight: Insight(
        type: .anomaly,
        title: "Step count was unusually high",
        description: "12,450 steps (z-score: 2.4, typical range: 4,200–7,800 steps).",
        priority: .high
    ))
    .padding()
}

#Preview("Medium Priority Trend") {
    InsightCardView(insight: Insight(
        type: .trend,
        title: "Resting heart rate is trending down",
        description: "Changed by 2.1 over the past 30 days (R² = 0.65).",
        priority: .medium
    ))
    .padding()
}

#Preview("Correlation") {
    InsightCardView(insight: Insight(
        type: .correlation,
        title: "HRV correlates with sleep duration",
        description: "Strong positive correlation (r = 0.72) based on 25 paired days.",
        priority: .medium
    ))
    .padding()
}

#Preview("Low Priority Comparison") {
    InsightCardView(insight: Insight(
        type: .comparison,
        title: "Active energy is up this week",
        description: "Average 485.2 kcal this week vs 412.8 kcal last week (+18%).",
        priority: .low
    ))
    .padding()
}
