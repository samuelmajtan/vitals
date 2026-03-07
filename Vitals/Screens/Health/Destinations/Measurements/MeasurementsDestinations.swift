//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

// MARK: - Destinations

@MainActor
enum MeasurementsDestinations: Hashable, @MainActor NavigationDestination {

    case types

}

// MARK: - Views

extension MeasurementsDestinations {

    var body: some View {
        switch self {
        case .types:
            MeasurementTypesScreen()
        }
    }

}

// MARK: - Methods

extension MeasurementsDestinations {

    var method: NavigationMethod {
        switch self {
        default: .push
        }
    }

}
