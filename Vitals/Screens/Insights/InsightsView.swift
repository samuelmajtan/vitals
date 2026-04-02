//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct InsightsView: View {

    // MARK: - Properties

    @Environment(\.navigator)
    private var navigator
    @State
    private var viewModel: InsightsViewModelProtocol

    // MARK: - Lifecycle

    init(viewModel: InsightsViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        Group {
            if viewModel.state.isLoadingOrIdle {
                loadingView
            } else if viewModel.insights.isEmpty {
                emptyView
            } else {
                contentView
            }
        }
        .animation(.easeInOut, value: viewModel.insights.count)
        .task { await viewModel.fetchInsights() }
        .refreshable { await viewModel.fetchInsights() }
    }

}

// MARK: - Content View

private extension InsightsView {

    var contentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constant.Spacing.lg) {
                summaryPills
                insightSections
            }
            .padding(.horizontal)
            .padding(.bottom, Constant.Spacing.xl)
        }
        .scrollIndicators(.hidden)
    }

}

// MARK: - Summary Pills

private extension InsightsView {

    var summaryPills: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Constant.Spacing.sm) {
                ForEach(InsightType.allCases, id: \.self) { type in
                    let count = viewModel.count(for: type)
                    if count > 0 {
                        summaryPill(type: type, count: count)
                    }
                }
            }
        }
    }

    func summaryPill(type: InsightType, count: Int) -> some View {
        HStack(spacing: Constant.Spacing.xs) {
            Image(systemName: type.image)
                .font(.caption2.bold())
            Text("\(count)")
                .font(.caption.bold())
            Text(type.title)
                .font(.caption)
        }
        .foregroundStyle(pillColor(for: type))
        .padding(.horizontal, Constant.Spacing.md)
        .padding(.vertical, Constant.Spacing.sm)
        .background(pillColor(for: type).opacity(0.1))
        .clipShape(Capsule())
    }

    func pillColor(for type: InsightType) -> Color {
        switch type {
        case .anomaly:     .red
        case .trend:       .teal
        case .correlation: .blue
        case .comparison:  .green
        }
    }

}

// MARK: - Insight Sections

private extension InsightsView {

    var insightSections: some View {
        ForEach(viewModel.activeTypes, id: \.self) { type in
            VStack(alignment: .leading, spacing: Constant.Spacing.md) {
                sectionHeader(for: type)
                insightCards(for: type)
            }
        }
    }

    func sectionHeader(for type: InsightType) -> some View {
        HStack(spacing: Constant.Spacing.sm) {
            Image(systemName: type.image)
                .font(.headline)
                .foregroundStyle(pillColor(for: type))
            Text(type.title)
                .font(.headline)
            Spacer()
            Text("\(viewModel.count(for: type))")
                .font(.subheadline.bold())
                .foregroundStyle(.secondary)
        }
        .padding(.top, Constant.Spacing.sm)
    }

    func insightCards(for type: InsightType) -> some View {
        ForEach(viewModel.insights(for: type)) { insight in
            InsightCardView(insight: insight)
        }
    }

}

// MARK: - Loading & Empty

private extension InsightsView {

    var loadingView: some View {
        VStack(spacing: Constant.Spacing.lg) {
            ProgressView()
                .controlSize(.large)
            Text("Analyzing your health data...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var emptyView: some View {
        ContentUnavailableView(
            "No Insights Yet",
            systemImage: "sparkles",
            description: Text("Insights will appear here as enough health data is collected. Keep wearing your Apple Watch!")
        )
    }

}

// MARK: - Preview

#Preview("With Insights") {
    InsightsView(viewModel: InsightsViewModel(state: .success("ok")))
}

#Preview("Loading") {
    InsightsView(viewModel: InsightsViewModel())
}
