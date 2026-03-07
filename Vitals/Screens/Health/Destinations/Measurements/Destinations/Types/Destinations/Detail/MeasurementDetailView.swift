//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MeasurementDetailView: View {

    // MARK: - Properties

    @Environment(\.navigator)
    private var navigator
    @State
    private var viewModel: MeasurementDetailViewModelProtocol

    // MARK: - Lifecycle

    init(viewModel: MeasurementDetailViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        List {
            VStack(alignment: .leading) {
                // TODO: Date Picker
                // TODO: Statistics
                // TODO: Chart
            }
            .listRowSeparator(.hidden)
        }
        .toolbar {
            Button {
                navigator.navigate(to: MeasurementDetailDestinations.placeholder)
            } label: {
                Image(systemName: "plus")
            }
        }
    }

}
