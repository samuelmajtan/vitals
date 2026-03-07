//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MedicationDetailScreen: View {
    
    // MARK: - View
    
    var body: some View {
        MedicationDetailView(viewModel: MedicationDetailViewModel())
            .navigationDestination(MedicationDetailDestinations.self)
            .navigationTitle("Detail")
            .onNavigationReceive { (destination: MedicationDetailDestinations, navigator) in
                navigator.navigate(to: destination)
                return .auto
            }
    }
    
}

// MARK: - Preview

#Preview {
    MedicationDetailScreen()
}
