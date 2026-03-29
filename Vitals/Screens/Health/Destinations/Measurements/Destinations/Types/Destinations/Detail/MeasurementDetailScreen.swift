//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MeasurementDetailScreen: View {
    
    // MARK: - Properties
    
    let context: MeasurementTypesDestinations.Context
    
    // MARK: - Lifecycle
    
    init(_ context: MeasurementTypesDestinations.Context) {
        self.context = context
    }

    // MARK: - View

    var body: some View {
        MeasurementDetailView(viewModel: MeasurementDetailViewModel(context))
            .navigationTitle(context.sample.type.title)
            .navigationBarTitleDisplayMode(.inline)
            .onNavigationReceive { (destination: MeasurementDetailDestinations, navigator) in
                navigator.navigate(to: destination)
                return .auto
            }
    }

}

// MARK: - Preview

#Preview {
    MeasurementDetailScreen(.init(.init(.init(VitalsSampleType.heartRate), date: Date(), value: 87, unit: "BPM")))
}
