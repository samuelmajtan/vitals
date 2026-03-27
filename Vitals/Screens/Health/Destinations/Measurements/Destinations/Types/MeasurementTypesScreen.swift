//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MeasurementTypesScreen: View {
    
    // MARK: - Properties
    
    let context: MeasurementsDestinations.Context
    
    // MARK: - Lifecycle
    
    init(_ context: MeasurementsDestinations.Context) {
        self.context = context
    }
    
    // MARK: - View
    
    var body: some View {
        MeasurementTypesView(viewModel: MeasurementTypesViewModel(context))
            .navigationTitle(context.category.title)
            .onNavigationReceive { (destination: MeasurementTypesDestinations, navigator) in
                navigator.navigate(to: destination)
                return .auto
            }
    }
    
}

// MARK: - Preview

#Preview {
    MeasurementTypesScreen(.init(.vitals))
}
