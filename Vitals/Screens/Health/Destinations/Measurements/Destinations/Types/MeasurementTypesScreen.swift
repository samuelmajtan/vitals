//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MeasurementTypesScreen: View {
    
    // MARK: - View
    
    var body: some View {
        MeasurementTypesView(viewModel: MeasurementTypesViewModel())
            .navigationTitle("Measurement Types")
            .onNavigationReceive { (destination: MeasurementTypesDestinations, navigator) in
                navigator.navigate(to: destination)
                return .auto
            }
    }
    
}

// MARK: - Preview

#Preview {
    MeasurementTypesScreen()
}
