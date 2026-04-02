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
        List {
            ForEach(viewModel.filteredCategories) { category in
                Section {
                    ForEach(viewModel.types(for: category)) { type in
                        NavigationLink(to: SearchDestinations.types(.init(category))) {
                            HStack(alignment: .center, spacing: Constant.Spacing.sm) {
                                Image(systemName: category.image)
                                    .foregroundStyle(category.color)
                                    .frame(width: 24)
                                Text(type.title)
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
                } header: {
                    HStack(spacing: Constant.Spacing.xs) {
                        Image(systemName: category.image)
                            .foregroundStyle(category.color)
                        Text(category.title)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .searchable(text: $viewModel.searchText, prompt: "Search health data")
        .overlay {
            if viewModel.filteredCategories.isEmpty {
                ContentUnavailableView.search(text: viewModel.searchText)
            }
        }
    }

}

// MARK: - Preview

#Preview {
    SearchView(viewModel: SearchViewModel())
}
