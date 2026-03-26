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
            GradientView(color: viewModel.context.measurementCategory.color)
            
            List {
                if viewModel.dailySamples.isNotEmpty {
                    Section("Today") {
                    }
                }
                
                if viewModel.weeklySamples.isNotEmpty {
                    Section("Past 7 days") {
                    }
                }
                
                if viewModel.monthlySamples.isNotEmpty {
                    Section("Past Month") {
                    }
                }
                
                if viewModel.emptySamples.isNotEmpty {
                    Section("No Data Available") {
                    }
                }
            }
            .headerProminence(.increased)
            .listRowSpacing(Constant.Spacing.md)
            .scrollContentBackground(.hidden)
        }
    }
    
}

#Preview {
    MeasurementTypesView(viewModel: MeasurementTypesViewModel(MeasurementsDestinations.Context(.vitals)))
}
