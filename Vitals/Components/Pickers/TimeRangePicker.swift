//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct TimeRangePicker: View {
    
    // MARK: - Properties

    @Binding
    var timeRange: TimeRange

    // MARK: - Lifecycle

    init(timeRange: Binding<TimeRange>) {
        self._timeRange = timeRange
    }

    // MARK: - View

    var body: some View {
        Picker(selection: $timeRange.animation(.easeInOut), label: EmptyView()) {
            ForEach(TimeRange.allCases) {
                Text($0.title)
                    .tag($0)
            }
        }
        .pickerStyle(.segmented)
    }

}

// MARK: - Preview

#Preview {
    TimeRangePicker(timeRange: .constant(.lastMonth))
}
