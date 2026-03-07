//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MedicationsScreen: View {
    
    // MARK: - View
    
    var body: some View {
        MedicationsView(viewModel: MedicationsViewModel())
            .navigationDestination(MedicationsDestinations.self)
            .navigationTitle("Medications")
            .onNavigationReceive { (destination: MedicationsDestinations, navigator) in
                navigator.navigate(to: destination)
                return .auto
            }
    }
    
}

// MARK: - Preview

#Preview {
    MedicationsScreen()
}
