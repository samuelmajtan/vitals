//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct InsightsView: View {
    
    // MARK: - Properties
    
    @Environment(\.navigator)
    private var navigator
    @State
    private var viewModel: InsightsViewModelProtocol
    
    // MARK: - Lifecycle
    
    init(viewModel: InsightsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Label("Insights under construction...", systemImage: "exclamationmark.triangle")
        }
    }
    
}

// MARK: - Preview

#Preview {
    InsightsView(viewModel: InsightsViewModel())
}
