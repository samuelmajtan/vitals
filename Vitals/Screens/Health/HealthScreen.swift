//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct HealthScreen: View {
    
    // MARK: - View
    
    var body: some View {
        ManagedNavigationStack(scene: RootTab.health.id) {
            HealthView(viewModel: HealthViewModel())
                .navigationCheckpoint(KnownCheckpoints.health)
                .navigationTitle("Health")
                .onNavigationReceive { (destination: HealthDestinations, navigator) in
                    navigator.navigate(to: destination)
                    return .auto
                }
        }
    }
    
}

// MARK: - Preview

#Preview {
    HealthScreen()
}
