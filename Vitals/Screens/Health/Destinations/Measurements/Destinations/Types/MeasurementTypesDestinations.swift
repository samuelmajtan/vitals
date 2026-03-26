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
    
    case detail(Self.Context)
    
}

// MARK: - Views

extension MeasurementTypesDestinations {
    
    var body: some View {
        switch self {
        case .detail(let context):
            MeasurementDetailScreen(context)
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

// MARK: - Context

extension MeasurementTypesDestinations {
    
    struct Context: Equatable, Hashable {

        let measurementType: AnySampleType

        init(_ measurementType: AnySampleType) {
            self.measurementType = measurementType
        }

    }
    
}
