//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct HealthView: View {
    
    // MARK: - Properties
    
    @Environment(\.navigator)
    private var navigator
    @State
    private var viewModel: HealthViewModelProtocol

    // MARK: - Lifecycle
    
    init(viewModel: HealthViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Button("Measurements") {
                navigator.navigate(to: HealthDestinations.measurements)
            }
        }
    }
    
}
