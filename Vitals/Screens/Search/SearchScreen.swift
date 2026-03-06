//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct SearchScreen: View {
    
    // MARK: - View
    
    var body: some View {
        ManagedNavigationStack(scene: RootTab.search.id) {
            SearchView(viewModel: SearchViewModel())
                .navigationCheckpoint(KnownCheckpoints.search)
                .navigationDestination(SearchDestinations.self)
                .navigationTitle("Search")
                .onNavigationReceive { (destination: SearchDestinations, navigator)  in
                    navigator.navigate(to: destination)
                    return .auto
                }
        }
    }
    
}

// MARK: - Preview

#Preview {
    SearchScreen()
}
