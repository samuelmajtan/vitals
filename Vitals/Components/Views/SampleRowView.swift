//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct SampleRowView: View {
    
    // MARK: - Properties
    
    let sample: MeasurementSample
    let category: MeasurementCategory

    // MARK: - Lifecycle

    init(_ sample: MeasurementSample, category: MeasurementCategory) {
        self.sample = sample
        self.category = category
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading, spacing: Constant.Spacing.xxl) {
            HStack(alignment: .center) {
                Label(sample.title, systemImage: category.image)
                    .foregroundStyle(category.color)
                    .font(.headline.bold())
                Spacer()
                Text(sample.date.formatted())
                    .foregroundStyle(.secondary)
                    .font(.footnote.bold())
            }
            HStack(alignment: .lastTextBaseline, spacing: Constant.Spacing.xs) {
                Text(sample.value.formatted())
                    .font(.title.bold())
                Text(sample.unit)
                    .foregroundStyle(.secondary)
                    .font(.headline.bold())
                Spacer()
                Image(systemName: "chart.dots.scatter")
            }
        }
    }

}

// MARK: - Preview

#Preview {
    SampleRowView(.init("Heart Rate", date: Date(), value: 79, unit: "BPM"), category: .vitals)
}
