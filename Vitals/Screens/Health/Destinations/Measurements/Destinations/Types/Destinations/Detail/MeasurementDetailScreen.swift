//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MeasurementDetailScreen: View {

    // MARK: - View

    var body: some View {
        MeasurementDetailView(viewModel: MeasurementDetailViewModel())
            .navigationDestination(MeasurementDetailDestinations.self)
            .navigationTitle("Detail")
            .onNavigationReceive { (destination: MeasurementDetailDestinations, navigator) in
                navigator.navigate(to: destination)
                return .auto
            }
    }

}

// MARK: - Preview

#Preview {
    MeasurementDetailScreen()
}
