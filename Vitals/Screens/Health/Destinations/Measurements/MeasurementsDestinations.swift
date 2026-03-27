//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

// MARK: - Destinations

enum MeasurementsDestinations: Hashable, @MainActor NavigationDestination {

    case types(Self.Context)

}

// MARK: - Views

extension MeasurementsDestinations {

    var body: some View {
        switch self {
        case .types(let context):
            MeasurementTypesScreen(context)
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

// MARK: - Context

extension MeasurementsDestinations {
    
    struct Context: Hashable {

        let category: SampleCategory
        
        init(_ category: SampleCategory) {
            self.category = category
        }

    }

}
