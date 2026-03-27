//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct SampleRowView: View {
    
    // MARK: - Properties
    
    let sample: Sample

    // MARK: - Lifecycle

    init(_ sample: Sample) {
        self.sample = sample
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading, spacing: Constant.Spacing.xxl) {
            HStack(alignment: .center) {
                Label(sample.type.title, systemImage: sample.type.category.image)
                    .foregroundStyle(sample.type.category.color)
                    .bold()
                Spacer()
                Text(sample.date.timeFormatted)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            HStack(alignment: .lastTextBaseline, spacing: Constant.Spacing.xs) {
                Text(sample.value.shortFormatted)
                    .font(.title3.bold())
                Text(sample.unit)
                    .foregroundStyle(.secondary)
                    .font(.subheadline.bold())
                Spacer()
                Image(systemName: "chart.dots.scatter")
            }
        }
    }

}

// MARK: - Preview

#Preview {
    SampleRowView(.init(.init(VitalsSampleType.heartRate), date: Date(), value: 79, unit: "BPM"))
}
