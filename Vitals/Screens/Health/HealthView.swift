//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

struct HealthView: View {

    // MARK: - Properties

    @State
    private var viewModel: HealthViewModelProtocol

    // MARK: - Lifecycle

    init(viewModel: HealthViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constant.Spacing.xl) {
                quickAccessSection
                categoriesSection
            }
            .padding(.horizontal)
            .padding(.bottom, Constant.Spacing.xxl)
        }
        .scrollIndicators(.hidden)
    }

}

// MARK: - Quick Access

private extension HealthView {

    var quickAccessSection: some View {
        VStack(alignment: .leading, spacing: Constant.Spacing.md) {
            Text("Quick Access")
                .font(.headline)

            HStack(spacing: Constant.Spacing.md) {
                quickAccessCard(
                    title: "Measurements",
                    image: SF.measurements.rawValue,
                    color: .teal,
                    destination: .measurements
                )
                quickAccessCard(
                    title: "Medications",
                    image: SF.medications.rawValue,
                    color: .purple,
                    destination: .medications
                )
            }
        }
    }

    func quickAccessCard(
        title: String,
        image: String,
        color: Color,
        destination: HealthDestinations
    ) -> some View {
        NavigationLink(to: destination) {
            VStack(spacing: Constant.Spacing.sm) {
                Image(systemName: image)
                    .font(.title2)
                    .foregroundStyle(color)
                Text(title)
                    .font(.caption.bold())
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Constant.Spacing.lg)
            .background(color.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: Constant.Radius.default))
            .overlay {
                RoundedRectangle(cornerRadius: Constant.Radius.default)
                    .strokeBorder(color.opacity(0.2), lineWidth: 1)
            }
        }
    }

}

// MARK: - Categories

private extension HealthView {

    var categoriesSection: some View {
        VStack(alignment: .leading, spacing: Constant.Spacing.md) {
            Text("Browse by Category")
                .font(.headline)

            LazyVStack(spacing: Constant.Spacing.sm) {
                ForEach(SampleCategory.allCases) { category in
                    NavigationLink(to: HealthDestinations.categoryDetail(.init(category))) {
                        categoryRow(category)
                    }
                }
            }
        }
    }

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
                    .font(.subheadline.bold())
                    .foregroundStyle(.primary)
                Text("\(category.types.count) types")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption.bold())
                .foregroundStyle(.tertiary)
        }
        .padding(Constant.Spacing.md)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: Constant.Radius.default))
    }

}
