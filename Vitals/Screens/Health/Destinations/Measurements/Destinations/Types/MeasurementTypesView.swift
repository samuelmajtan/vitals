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
            
            List {
                ForEach(SampleInterval.allCases, id: \.self) { interval in
                    sectionView(for: interval)
                }
                
                if viewModel.emptySamples.isNotEmpty {
                    Section("No Data Available") {
                        ForEach(viewModel.emptySamples) { type in
                            Text(type.title)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .headerProminence(.increased)
            .listRowSpacing(Constant.Spacing.md)
            .scrollContentBackground(.hidden)
            .task { await viewModel.fetchSamples() }
        }
    }
    
    // MARK: - Section builder
    
    @ViewBuilder
    private func sectionView(for interval: SampleInterval) -> some View {
        let samples = samples(for: interval)
        
        if samples.isNotEmpty {
            Section(interval.title) {
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
            }
        }
    }
    
    private func samples(for interval: SampleInterval) -> [Sample] {
        switch interval {
        case .daily:   return viewModel.dailySamples
        case .weekly:  return viewModel.weeklySamples
        case .monthly: return viewModel.monthlySamples
        }
    }

}

// MARK: - Preview

#Preview {
    MeasurementTypesView(
        viewModel: MeasurementTypesViewModel(MeasurementsDestinations.Context(.vitals))
    )
}
