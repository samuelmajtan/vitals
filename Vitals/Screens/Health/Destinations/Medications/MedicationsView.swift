//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct MedicationsView: View {

    // MARK: - Properties

    @State
    private var viewModel: MedicationsViewModelProtocol

    // MARK: - Lifecycle

    init(viewModel: MedicationsViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        VStack {
            Text("Medications")
        }
    }

}

// MARK: - Preview

#Preview {
    
}
