//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct MeasurementsView: View {

    // MARK: - Properties

    @State
    private var viewModel: MeasurementsViewModelProtocol

    // MARK: - Lifecycle

    init(viewModel: MeasurementsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        List {
            ForEach(MeasurementCategory.allCases) { category in
                NavigationLink(to: MeasurementsDestinations.types(.init(category))) {
                    HStack(alignment: .center) {
                        Image(systemName: category.image)
                            .foregroundStyle(category.color)
                        Text(category.title)
                            .foregroundStyle(.primary)
                            .bold()
                    }
                }
            }
        }
        .listStyle(.inset)
    }
    
}
