//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct SampleRowView: View {
   
    // MARK: - Properties

    let title: String
    let image: String
    let color: Color
    let date: Date
    let value: Double
    let unit: String
    
    // MARK: - Lifecycle
    
    init(
        _ title: String,
        image: String,
        color: Color,
        date: Date,
        value: Double,
        unit: String
    ) {
        self.title = title
        self.image = image
        self.color = color
        self.date = date
        self.value = value
        self.unit = unit
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constant.Spacing.xxl) {
            HStack(alignment: .center) {
                Label(title, systemImage: image)
                    .foregroundStyle(color)
                    .bold()
                Spacer()
                Text(date.timeFormatted)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            HStack(alignment: .lastTextBaseline, spacing: Constant.Spacing.xs) {
                Text(value.shortFormatted)
                    .font(.title3.bold())
                Text(unit)
                    .foregroundStyle(.secondary)
                    .font(.subheadline.bold())
                Spacer()
            }
        }
    }
    
}

// MARK: - Preview

#Preview {
    SampleRowView("Heart Rate", image: "heart", color: .red, date: Date(), value: 87, unit: "BPM")
}
