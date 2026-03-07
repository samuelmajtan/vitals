//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

// MARK: - Destinations

@MainActor
enum HealthDestinations: Hashable, @MainActor NavigationDestination {
    
    case measurements
    case medications
    
}

// MARK: - Views

extension HealthDestinations {
    
    @ViewBuilder
    var body: some View {
        switch self {
        case .measurements:
            MeasurementsScreen()
        case .medications:
            MedicationsScreen()
        }
    }
    
}

// MARK: - Methods

extension HealthDestinations {
    
    var method: NavigationMethod {
        switch self {
        default: .push
        }
    }
    
}
