//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct MedicationDetailView: View {
    
    // MARK: - Properties
    
    @State
    private var viewModel: MedicationDetailViewModelProtocol
    
    // MARK: - Lifecycle
    
    init(viewModel: MedicationDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        Text("Medication Detail")
    }
    
}

// MARK: - Preview

#Preview {
    
}
