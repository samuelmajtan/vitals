//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct HomeView: View {

    // MARK: - Properties

    @Environment(\.navigator)
    private var navigator
    @State
    private var viewModel: HomeViewModelProtocol

    // MARK: - Lifecycle

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        Group {
            contentView
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.state.isLoading)
        .task { await viewModel.fetchDashboard() }
        .refreshable { await viewModel.fetchDashboard() }
    }

}

// MARK: - Content

private extension HomeView {

    var contentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constant.Spacing.xl) {
                metricsGrid
                insightsSection
            }
            .padding(.horizontal)
            .padding(.bottom, Constant.Spacing.xxl)
        }
        .scrollIndicators(.hidden)
    }

}

// MARK: - Metrics Grid

private extension HomeView {

    var metricsGrid: some View {
        VStack(alignment: .leading, spacing: Constant.Spacing.md) {
            Text("Today's Overview")
                .font(.headline)

            if viewModel.metrics.isEmpty {
                emptyMetricsView
            } else {
                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: Constant.Spacing.md
                ) {
                    ForEach(viewModel.metrics) { metric in
                        MetricCardView(
                            title: metric.title,
                            image: metric.image,
                            color: metric.color,
                            value: metric.value,
                            unit: metric.unit,
                            trend: metric.trend
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            navigator.navigate(
                                to: HomeDestinations.measurements(.init(metric.category))
                            )
                        }
                    }
                }
            }
        }
    }

    var emptyMetricsView: some View {
        VStack(spacing: Constant.Spacing.md) {
            Image(systemName: "heart.text.clipboard")
                .font(.largeTitle)
                .foregroundStyle(.tertiary)
            Text("No health data available yet")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Constant.Spacing.xxl)
    }

}

// MARK: - Insights Section

private extension HomeView {

    @ViewBuilder
    var insightsSection: some View {
        if !viewModel.recentInsights.isEmpty {
            VStack(alignment: .leading, spacing: Constant.Spacing.md) {
                HStack {
                    Text("Recent Insights")
                        .font(.headline)
                    Spacer()
                    Button {
                        print("Navigate to...")
                    } label: {
                        Text("See All")
                            .font(.subheadline.bold())
                    }
                }

                ForEach(viewModel.recentInsights) { insight in
                    InsightCardView(insight: insight)
                }
            }
        }
    }

}

// MARK: - Loading

private extension HomeView {

    var loadingView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constant.Spacing.xl) {
                VStack(alignment: .leading, spacing: Constant.Spacing.xs) {
                    RoundedRectangle(cornerRadius: Constant.Radius.xs)
                        .fill(.quaternary)
                        .frame(width: 200, height: 28)
                    RoundedRectangle(cornerRadius: Constant.Radius.xs)
                        .fill(.quaternary)
                        .frame(width: 160, height: 18)
                }
                .padding(.top, Constant.Spacing.sm)

                RoundedRectangle(cornerRadius: Constant.Radius.xs)
                    .fill(.quaternary)
                    .frame(width: 140, height: 20)

                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: Constant.Spacing.md
                ) {
                    ForEach(0..<6, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: Constant.Radius.default)
                            .fill(.quaternary)
                            .frame(height: 100)
                    }
                }
            }
            .padding(.horizontal)
            .redacted(reason: .placeholder)
        }
        .scrollIndicators(.hidden)
    }

}

// MARK: - Preview

#Preview {
    HomeView(viewModel: HomeViewModel())
}
