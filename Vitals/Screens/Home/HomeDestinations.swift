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

    case measurements(MeasurementsDestinations.Context)

}

// MARK: - Views

extension HomeDestinations {

    var body: some View {
        switch self {
        case .measurements(let context):
            MeasurementTypesScreen(context)
        }
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
