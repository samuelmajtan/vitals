//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct InsightsScreen: View {
    
    // MARK: - View
    
    var body: some View {
        ManagedNavigationStack(scene: RootTab.insights.id) {
            InsightsView(viewModel: InsightsViewModel())
                .navigationCheckpoint(KnownCheckpoints.insights)
                .navigationTitle("Insights")
                .onNavigationReceive { (destination: InsightsDestinations, navigator) in
                    navigator.navigate(to: destination)
                    return .auto
                }
        }
    }
    
}

// MARK: - Preview

#Preview {
    InsightsScreen()
}
