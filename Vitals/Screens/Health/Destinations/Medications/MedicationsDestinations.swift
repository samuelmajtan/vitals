//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

// MARK: - Destinations

@MainActor
enum MedicationsDestinations: Hashable, @MainActor NavigationDestination {

    case detail

}

// MARK: - Views

extension MedicationsDestinations {
    
    var body: some View {
        switch self {
        case .detail:
            MedicationDetailScreen()
        }
    }

}

// MARK: - Methods

extension MedicationsDestinations {

    var method: NavigationMethod {
        switch self {
        default: .push
        }
    }

}
