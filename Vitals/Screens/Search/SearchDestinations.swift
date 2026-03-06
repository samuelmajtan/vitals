//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

// MARK: - Destinations

@MainActor
enum SearchDestinations: Hashable, @MainActor NavigationDestination {
    
    case placeholder
    
}

// MARK: - Views

extension SearchDestinations {
    
    var body: some View {
        Text("Place destinations here...")
    }
    
}

// MARK: - Methods

extension SearchDestinations {
    
    var method: NavigationMethod {
        switch self {
        default: .push
        }
    }
    
}
