//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct HomeView: View {

    // MARK: - Properties
    
    @Environment(\.navigator)
    private var navigator
    @State
    private var viewModel: HomeViewModelProtocol

    // MARK: - Lifecycle

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - View

    var body: some View {
        VStack {
            Label("Home under construction...", systemImage: "exclamationmark.triangle")
        }
    }

}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
