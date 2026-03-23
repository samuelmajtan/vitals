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
                Section("Samples") {
                    ForEach(viewModel.context.measurementCategory.types) { type in
                        NavigationLink(to: MeasurementTypesDestinations.detail(.init(type))) {
                            Text(type.title)
                        }
                    }
                }

                Section("No Data Available") {
                        
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
