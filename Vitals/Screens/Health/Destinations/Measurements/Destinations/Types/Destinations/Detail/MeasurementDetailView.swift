//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI
import AnalysisKit

struct MeasurementDetailView: View {

    // MARK: - Properties

    @Environment(\.navigator)
    private var navigator
    @State
    private var viewModel: MeasurementDetailViewModelProtocol

    // MARK: - Lifecycle

    init(viewModel: MeasurementDetailViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constant.Spacing.lg) {
                pickerSection
                summarySection
                chartSection
                statisticsSection
                trendSection
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .animation(.easeInOut(duration: 0.3), value: viewModel.timeRange)
        .task { await viewModel.fetchSamples() }
        .onChange(of: viewModel.timeRange) {
            Task { await viewModel.fetchSamples() }
        }
    }

}

// MARK: - Picker & Summary

private extension MeasurementDetailView {

    var pickerSection: some View {
        TimeRangePicker(timeRange: $viewModel.timeRange)
    }

    var summarySection: some View {
        SampleSummaryView(
            viewModel.context.sample.type.config.summaryLabel,
            value: viewModel.context.sample.value,
            unit: viewModel.context.sample.unit,
            timeRange: viewModel.timeRange
        )
    }

}

// MARK: - Chart

private extension MeasurementDetailView {

    var chartSection: some View {
        DetailChart(
            source: viewModel.sampleData,
            style: viewModel.context.sample.type.config.chartStyle,
            unit: viewModel.context.sample.unit,
            barUnit: viewModel.context.sample.type.config.barUnit
        )
        .frame(height: 220)
    }

}

// MARK: - Statistics

private extension MeasurementDetailView {

    @ViewBuilder
    var statisticsSection: some View {
        if let stats = viewModel.statistics {
            VStack(alignment: .leading, spacing: Constant.Spacing.md) {
                Text("Statistics")
                    .font(.headline)

                let unit = viewModel.context.sample.unit

                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: Constant.Spacing.sm
                ) {
                    statCell(label: "Average", value: stats.mean, unit: unit)
                    statCell(label: "Median", value: stats.median, unit: unit)
                    statCell(label: "Minimum", value: stats.min, unit: unit)
                    statCell(label: "Maximum", value: stats.max, unit: unit)
                    statCell(label: "Std. Deviation", value: stats.standardDeviation, unit: unit)
                    statCell(label: "Samples", value: Double(stats.count), unit: "")
                }
            }
        }
    }

    func statCell(label: String, value: Double, unit: String) -> some View {
        VStack(alignment: .leading, spacing: Constant.Spacing.xs) {
            Text(label.uppercased())
                .font(.caption2.bold())
                .foregroundStyle(.secondary)
            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text(value.shortFormatted)
                    .font(.subheadline.bold())
                    .foregroundStyle(.primary)
                if !unit.isEmpty {
                    Text(unit)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Constant.Spacing.md)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: Constant.Radius.sm))
    }

}

// MARK: - Trend

private extension MeasurementDetailView {

    @ViewBuilder
    var trendSection: some View {
        if let trend = viewModel.trend, trend.trend != .stable || trend.rSquared > 0.1 {
            VStack(alignment: .leading, spacing: Constant.Spacing.md) {
                Text("Trend Analysis")
                    .font(.headline)

                HStack(spacing: Constant.Spacing.md) {
                    trendDirectionView(trend)
                    trendDetailsView(trend)
                }
                .padding(Constant.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(trendColor(trend.trend).opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: Constant.Radius.default))
                .overlay {
                    RoundedRectangle(cornerRadius: Constant.Radius.default)
                        .strokeBorder(trendColor(trend.trend).opacity(0.2), lineWidth: 1)
                }
            }
        }
    }

    func trendDirectionView(_ trend: LinearRegressionResult) -> some View {
        VStack(spacing: Constant.Spacing.xs) {
            Image(systemName: trendIcon(trend.trend))
                .font(.title2.bold())
                .foregroundStyle(trendColor(trend.trend))
            Text(trend.trend.rawValue.capitalized)
                .font(.caption.bold())
                .foregroundStyle(trendColor(trend.trend))
        }
        .frame(width: 80)
    }

    func trendDetailsView(_ trend: LinearRegressionResult) -> some View {
        VStack(alignment: .leading, spacing: Constant.Spacing.xs) {
            HStack(spacing: Constant.Spacing.xs) {
                Text("Slope")
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
                Text(String(format: "%+.2f / day", trend.slope))
                    .font(.caption)
                    .foregroundStyle(.primary)
            }
            HStack(spacing: Constant.Spacing.xs) {
                Text("Fit (R²)")
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
                Text(String(format: "%.2f", trend.rSquared))
                    .font(.caption)
                    .foregroundStyle(.primary)

                fitQualityBadge(trend.rSquared)
            }
        }
    }

    func fitQualityBadge(_ rSquared: Double) -> some View {
        let (text, color): (String, Color) = {
            switch rSquared {
            case 0.7...: ("Strong", .green)
            case 0.4...: ("Moderate", .orange)
            default:     ("Weak", .secondary)
            }
        }()

        return Text(text)
            .font(.caption2.bold())
            .foregroundStyle(color)
            .padding(.horizontal, Constant.Spacing.xs)
            .padding(.vertical, 2)
            .background(color.opacity(0.15))
            .clipShape(Capsule())
    }

    func trendIcon(_ direction: TrendDirection) -> String {
        switch direction {
        case .increasing: "arrow.up.right.circle.fill"
        case .decreasing: "arrow.down.right.circle.fill"
        case .stable:     "arrow.right.circle.fill"
        }
    }

    func trendColor(_ direction: TrendDirection) -> Color {
        switch direction {
        case .increasing: .green
        case .decreasing: .red
        case .stable:     .secondary
        }
    }

}
