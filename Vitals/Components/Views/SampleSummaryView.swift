//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct SampleSummaryView: View {

    // MARK: - Properties

    let label: SummaryLabel
    let value: Double
    let unit: String
    let timeRange: TimeRange

    // MARK: - Lifecycle

    init(_ label: SummaryLabel, value: Double, unit: String, timeRange: TimeRange) {
        self.label = label
        self.value = value
        self.unit = unit
        self.timeRange = timeRange
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading) {
            Text(label.title.uppercased())
                .foregroundStyle(.secondary)
                .font(.caption.bold())
            HStack(alignment: .lastTextBaseline, spacing: Constant.Spacing.xs) {
                Text(value.shortFormatted)
                    .foregroundStyle(.primary)
                    .font(.title2.bold())
                Text(unit)
                    .foregroundStyle(.secondary)
                    .font(.subheadline.bold())
            }
            Text(timeRange.description)
                .foregroundStyle(.secondary)
                .font(.footnote.bold())
        }
    }

}

// MARK: - Preview

#Preview {
}
