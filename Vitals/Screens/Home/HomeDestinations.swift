//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

// MARK: - Destinations

@MainActor
enum HomeDestinations: Hashable, @MainActor NavigationDestination {
    
    case placeholder
    
}

// MARK: - Views

extension HomeDestinations {
    
    var body: some View {
        Text("Place destinations here...")
    }
    
}

// MARK: - Methods

extension HomeDestinations {
    
    var method: NavigationMethod {
        switch self {
        default: .push
        }
    }
    
}
