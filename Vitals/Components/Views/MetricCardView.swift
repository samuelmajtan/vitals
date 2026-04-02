//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import AnalysisKit

struct MetricCardView: View {

    // MARK: - Properties

    let title: String
    let image: String
    let color: Color
    let value: String
    let unit: String
    let trend: TrendDirection?

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading, spacing: Constant.Spacing.sm) {
            header
            Spacer()
            valueRow
        }
        .padding(Constant.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: Constant.Radius.default))
        .overlay {
            RoundedRectangle(cornerRadius: Constant.Radius.default)
                .strokeBorder(color.opacity(0.2), lineWidth: 1)
        }
    }

}

// MARK: - Subviews

private extension MetricCardView {

    var header: some View {
        HStack(spacing: Constant.Spacing.xs) {
            Image(systemName: image)
                .font(.caption.bold())
                .foregroundStyle(color)
            Text(title)
                .font(.caption.bold())
                .foregroundStyle(color)
            Spacer()
            trendBadge
        }
    }

    var valueRow: some View {
        HStack(alignment: .lastTextBaseline, spacing: Constant.Spacing.xs) {
            Text(value)
                .font(.title2.bold())
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text(unit)
                .font(.caption.bold())
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    var trendBadge: some View {
        if let trend, trend != .stable {
            HStack(spacing: 2) {
                Image(systemName: trend == .increasing ? "arrow.up.right" : "arrow.down.right")
                    .font(.system(size: 10, weight: .bold))
            }
            .foregroundStyle(trendColor(trend))
            .padding(.horizontal, Constant.Spacing.xs)
            .padding(.vertical, 2)
            .background(trendColor(trend).opacity(0.15))
            .clipShape(Capsule())
        } else if trend == .stable {
            Image(systemName: "arrow.right")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.secondary)
                .padding(.horizontal, Constant.Spacing.xs)
                .padding(.vertical, 2)
                .background(Color.secondary.opacity(0.1))
                .clipShape(Capsule())
        }
    }

    func trendColor(_ trend: TrendDirection) -> Color {
        switch trend {
        case .increasing: .green
        case .decreasing: .red
        case .stable:     .secondary
        }
    }

}

// MARK: - Preview

#Preview("Grid") {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
        MetricCardView(
            title: "Heart Rate",
            image: "heart.fill",
            color: .red,
            value: "72",
            unit: "BPM",
            trend: .decreasing
        )
        MetricCardView(
            title: "Steps",
            image: "figure.walk",
            color: .orange,
            value: "8,432",
            unit: "steps",
            trend: .increasing
        )
        MetricCardView(
            title: "Sleep",
            image: "bed.double.fill",
            color: .indigo,
            value: "7.2",
            unit: "h",
            trend: .stable
        )
        MetricCardView(
            title: "Energy",
            image: "flame.fill",
            color: .green,
            value: "485",
            unit: "kcal",
            trend: nil
        )
    }
    .padding()
}
