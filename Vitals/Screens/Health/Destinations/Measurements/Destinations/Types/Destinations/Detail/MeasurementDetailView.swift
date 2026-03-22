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
        ScrollView {
            VStack(alignment: .leading) {
                TimeRangePicker(timeRange: $viewModel.timeRange)
            }
            .padding()
        }
    }

}
