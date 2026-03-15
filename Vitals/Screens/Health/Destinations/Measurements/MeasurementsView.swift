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
        List {
            ForEach(HealthCategory.allCases) { category in
                Button {
                    navigator.navigate(to: MeasurementsDestinations.types)
                } label: {
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
