//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import Charts

struct OverviewChart: View {

    // MARK: - Properties
    
    let source: [SampleData]
    
    // MARK: - Lifecycle
    
    init(source: [SampleData]) {
        self.source = source
    }

    // MARK: - View

    var body: some View {
        Chart(source) { data in
            PointMark(
                x: .value("Day", data.date),
                y: .value("Value", data.value)
            )
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }

}

// MARK: - Preview

#Preview {
    //OverviewChart()
}
