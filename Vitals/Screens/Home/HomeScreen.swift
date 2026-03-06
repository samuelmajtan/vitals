//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct HomeScreen: View {
    
    // MARK: - View
    
    var body: some View {
        ManagedNavigationStack(scene: RootTab.home.id) {
            HomeView(viewModel: HomeViewModel())
                .navigationCheckpoint(KnownCheckpoints.home)
                .navigationDestination(HomeDestinations.self)
                .navigationTitle("Home")
                .onNavigationReceive { (destination: HomeDestinations, navigator) in
                    navigator.navigate(to: destination)
                    return .auto
                }
        }
    }
    
}

// MARK: - Preview

#Preview {
    HomeScreen()
}
