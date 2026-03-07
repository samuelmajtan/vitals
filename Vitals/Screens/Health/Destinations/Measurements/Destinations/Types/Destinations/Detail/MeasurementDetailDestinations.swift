//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

// MARK: - Destinations

@MainActor
enum MeasurementDetailDestinations: Hashable, @MainActor NavigationDestination {

    case placeholder

}

// MARK: - Views

extension MeasurementDetailDestinations {
    
    var body: some View {
        Text("Place destinations here...")
    }
    
}

// MARK: - Methods

extension MeasurementDetailDestinations {
    
    var method: NavigationMethod {
        switch self {
        default: .push
        }
    }
    
}
