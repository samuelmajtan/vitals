//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MeasurementsView: View {

    // MARK: - Properties

    @Environment(\.navigator)
    private var navigator
    @State
    private var viewModel: MeasurementsViewModelProtocol

    // MARK: - Lifecycle

    init(viewModel: MeasurementsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        Text("Measurements")
    }
    
}
