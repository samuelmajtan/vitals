//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

enum TimeRange: CaseIterable, Identifiable {

    case lastHour
    case lastDay
    case lastWeek
    case lastMonth
    case lastYear

    var title: String {
        switch self {
        case .lastHour:
            "H"
        case .lastDay:
            "D"
        case .lastWeek:
            "W"
        case .lastMonth:
            "M"
        case .lastYear:
            "Y"
        }
    }

    var id: Self {
        self
    }

}

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
