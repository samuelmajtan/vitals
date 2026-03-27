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
                if viewModel.dailySamples.isNotEmpty {
                    Section("Today") {
                        ForEach(viewModel.dailySamples) { sample in
                            NavigationLink(to: MeasurementTypesDestinations.detail(.init(sample.type))) {
                                SampleRowView(sample)
                            }
                        }
                    }
                }
                
                if viewModel.weeklySamples.isNotEmpty {
                    Section("Past 7 days") {
                        ForEach(viewModel.weeklySamples) { sample in
                            NavigationLink(to: MeasurementTypesDestinations.detail(.init(sample.type))) {
                                SampleRowView(sample)
                            }
                        }
                    }
                }
                
                if viewModel.monthlySamples.isNotEmpty {
                    Section("Past Month") {
                        ForEach(viewModel.monthlySamples) { sample in
                            NavigationLink(to: MeasurementTypesDestinations.detail(.init(sample.type))) {
                                SampleRowView(sample)
                            }
                        }
                    }
                }
                
                if viewModel.emptySamples.isNotEmpty {
                    Section("No Data Available") {
                        ForEach(viewModel.emptySamples) { sample in
                            Text(sample.type.title)
                        }
                    }
                }
            }
            .headerProminence(.increased)
            .listRowSpacing(Constant.Spacing.md)
            .scrollContentBackground(.hidden)
            .task {
                await viewModel.fetchSamples()
            }
        }
    }
    
}

#Preview {
    MeasurementTypesView(viewModel: MeasurementTypesViewModel(MeasurementsDestinations.Context(.vitals)))
}
