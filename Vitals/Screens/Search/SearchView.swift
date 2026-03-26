//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct SearchView: View {
    
    // MARK: - Properties
    
    @Environment(\.navigator)
    private var navigator
    @State
    private var viewModel: SearchViewModelProtocol
    
    // MARK: - Lifecycle
    
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Label("Search under construction...", systemImage: "exclamationmark.triangle")
        }
    }
    
}

// MARK: - Preview

#Preview {
    SearchView(viewModel: SearchViewModel())
}
