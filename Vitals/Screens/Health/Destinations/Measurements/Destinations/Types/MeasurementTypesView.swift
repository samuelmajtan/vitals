//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI
import HealthKit

struct MeasurementTypesView: View {

    // MARK: - Properties

    @State
    private var viewModel: MeasurementTypesViewModelProtocol

    // MARK: - Lifecycle

    init(viewModel: MeasurementTypesViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        ZStack(alignment: .top) {
            GradientView(color: viewModel.context.category.color)

            Group {
                  contentView
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.state.isLoading)
            .task { await viewModel.fetchSamples() }
            .refreshable { await viewModel.fetchSamples() }
        }
    }

}

// MARK: - Content

private extension MeasurementTypesView {

    var hasNoData: Bool {
        viewModel.dailySamples.isEmpty
            && viewModel.weeklySamples.isEmpty
            && viewModel.monthlySamples.isEmpty
    }

    var contentView: some View {
        List {
            ForEach(SampleInterval.allCases, id: \.self) { interval in
                sectionView(for: interval)
            }

            if viewModel.emptySamples.isNotEmpty {
                Section {
                    ForEach(viewModel.emptySamples) { type in
                        HStack(spacing: Constant.Spacing.sm) {
                            Image(systemName: viewModel.context.category.image)
                                .foregroundStyle(.tertiary)
                                .frame(width: 20)
                            Text(type.title)
                                .foregroundStyle(.secondary)
                        }
                    }
                } header: {
                    Label("No Data Available", systemImage: "minus.circle")
                }
            }
        }
        .headerProminence(.increased)
        .listRowSpacing(Constant.Spacing.md)
        .scrollContentBackground(.hidden)
    }

}

// MARK: - Sections

private extension MeasurementTypesView {

    @ViewBuilder
    func sectionView(for interval: SampleInterval) -> some View {
        let samples = samples(for: interval)

        if samples.isNotEmpty {
            Section {
                ForEach(samples) { sample in
                    NavigationLink(to: MeasurementTypesDestinations.detail(.init(sample))) {
                        SampleRowView(
                            sample.type.title,
                            image: sample.type.category.image,
                            color: sample.type.category.color,
                            date: sample.date,
                            value: sample.value,
                            unit: sample.unit
                        )
                    }
                }
            } header: {
                Label(interval.title, systemImage: intervalIcon(for: interval))
            }
        }
    }

    func samples(for interval: SampleInterval) -> [Sample] {
        switch interval {
        case .daily:   return viewModel.dailySamples
        case .weekly:  return viewModel.weeklySamples
        case .monthly: return viewModel.monthlySamples
        }
    }

    func intervalIcon(for interval: SampleInterval) -> String {
        switch interval {
        case .daily:   "clock"
        case .weekly:  "calendar.badge.clock"
        case .monthly: "calendar"
        }
    }

}

// MARK: - Loading & Empty

private extension MeasurementTypesView {

    var loadingView: some View {
        List {
            ForEach(0..<8, id: \.self) { _ in
                HStack(spacing: Constant.Spacing.md) {
                    RoundedRectangle(cornerRadius: Constant.Radius.xs)
                        .fill(.quaternary)
                        .frame(width: 28, height: 28)
                    VStack(alignment: .leading, spacing: Constant.Spacing.xs) {
                        RoundedRectangle(cornerRadius: Constant.Radius.xs)
                            .fill(.quaternary)
                            .frame(width: 140, height: 14)
                        RoundedRectangle(cornerRadius: Constant.Radius.xs)
                            .fill(.quaternary)
                            .frame(width: 80, height: 12)
                    }
                    Spacer()
                    RoundedRectangle(cornerRadius: Constant.Radius.xs)
                        .fill(.quaternary)
                        .frame(width: 50, height: 20)
                }
                .padding(.vertical, Constant.Spacing.sm)
            }
        }
        .listRowSpacing(Constant.Spacing.md)
        .scrollContentBackground(.hidden)
        .redacted(reason: .placeholder)
    }

    var emptyView: some View {
        ContentUnavailableView(
            "No Measurements",
            systemImage: "heart.slash",
            description: Text("No data available for \(viewModel.context.category.title). Make sure your Apple Watch is connected and syncing.")
        )
    }

}

// MARK: - Preview

#Preview {
    MeasurementTypesView(
        viewModel: MeasurementTypesViewModel(MeasurementsDestinations.Context(.vitals))
    )
}
