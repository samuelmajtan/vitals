//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MeasurementsScreen: View {

    // MARK: - View
    
    var body: some View {
        MeasurementsView(viewModel: MeasurementsViewModel())
            .navigationTitle("Measurements")
            .onNavigationReceive { (destination: MeasurementsDestinations, navigator) in
                navigator.navigate(to: destination)
                return .auto
            }
    }

}

// MARK: - Preview

#Preview {
    MeasurementsScreen()
}
