//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

// MARK: - Destinations

@MainActor
enum InsightsDestinations: Hashable, @MainActor NavigationDestination {
    
    case placeholder
    
}

// MARK: - Views

extension InsightsDestinations {
    
    var body: some View {
        Text("Place destinations here...")
    }
    
}

// MARK: - Methods

extension InsightsDestinations {
    
    var method: NavigationMethod {
        switch self {
        default: .push
        }
    }
    
}
