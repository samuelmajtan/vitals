//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

// MARK: - Destinations

@MainActor
enum MeasurementTypesDestinations: Hashable, @MainActor NavigationDestination {
    
    case detail
    
}

// MARK: - Views

extension MeasurementTypesDestinations {
    
    var body: some View {
        switch self {
        case .detail:
            MeasurementDetailScreen()
        }
    }
    
}

// MARK: - Methods

extension MeasurementTypesDestinations {
    
    var method: NavigationMethod {
        switch self {
        default: .push
        }
    }
    
}
