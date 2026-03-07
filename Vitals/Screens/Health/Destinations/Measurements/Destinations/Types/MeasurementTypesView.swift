//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MeasurementTypesView: View {
    
    // MARK: - Properties
    
    @Environment(\.navigator)
    private var navigator
    @State
    private var viewModel: MeasurementTypesViewModelProtocol
    
    // MARK: - Lifecycle
    
    init(viewModel: MeasurementTypesViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Button("Go to detail...") {
                navigator.navigate(to: MeasurementTypesDestinations.detail)
            }
        }
    }

}

