//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

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
            }
            .scrollContentBackground(.hidden)
        }
    }
    
}

#Preview {
    MeasurementTypesView(viewModel: MeasurementTypesViewModel(MeasurementsDestinations.Context(.vitals)))
}
