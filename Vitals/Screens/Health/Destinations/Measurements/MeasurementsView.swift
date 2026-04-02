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
            ForEach(SampleCategory.allCases) { category in
                NavigationLink(to: MeasurementsDestinations.types(.init(category))) {
                    categoryRow(category)
                }
            }
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(Constant.Spacing.xs)
    }

}

// MARK: - Category Row

private extension MeasurementsView {

    func categoryRow(_ category: SampleCategory) -> some View {
        HStack(spacing: Constant.Spacing.md) {
            Image(systemName: category.image)
                .font(.body.bold())
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(category.color.gradient)
                .clipShape(RoundedRectangle(cornerRadius: Constant.Radius.sm))

            VStack(alignment: .leading, spacing: 2) {
                Text(category.title)
                    .foregroundStyle(.primary)
                    .font(.body.bold())
                Text("\(category.types.count) measurements")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
        }
        .padding(.vertical, Constant.Spacing.xs)
    }

}

// MARK: - Preview

#Preview {
    MeasurementsView(viewModel: MeasurementsViewModel())
}
