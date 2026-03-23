//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct HealthView: View {
    
    // MARK: - Properties
    
    @State
    private var viewModel: HealthViewModelProtocol

    // MARK: - Lifecycle
    
    init(viewModel: HealthViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        List {
            NavigationLink(to: HealthDestinations.measurements) {
                Label("Measurements", systemImage: SF.measurements.rawValue)
            }
            NavigationLink(to: HealthDestinations.medications) {
                Label("Medications", systemImage: SF.medications.rawValue)
            }
        }
        .listStyle(.inset)
    }
    
}
