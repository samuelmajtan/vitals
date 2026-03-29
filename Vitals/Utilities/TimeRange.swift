//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

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

    var dateInterval: DateInterval {
        switch self {
        case .lastHour:
            Date.hourlyInterval
        case .lastDay:
            Date.dailyInterval
        case .lastWeek:
            Date.weeklyInterval
        case .lastMonth:
            Date.monthlyInterval
        case .lastYear:
            Date.yearlyInterval
        }
    }

    var id: Self {
        self
    }

}

extension TimeRange: CustomStringConvertible {
    
    var description: String {
        let start = dateInterval.start
        let end = dateInterval.end
        
        switch self {
        case .lastHour:
            return "Today, \(format(start, .HHmm))–\(format(end, .HHmm))"
        case .lastDay:
            return "Today"
        case .lastWeek:
            let sameMonth = Calendar.current.isDate(start, equalTo: end, toGranularity: .month)
            return "\(format(start, sameMonth ? .d : .dMMM))–\(format(end, .dMMMyyyy))"
        case .lastMonth:
            return "\(format(start, .dMMM))–\(format(end, .dMMMyyyy))"
        case .lastYear:
            return "\(format(start, .MMMyyyy))–\(format(end, .MMMyyyy))"
        }
    }

    private func format(_ date: Date, _ format: DateFormatter.DateFormat) -> String {
        DateFormatter.dateString(date: date, format: format)
    }

}
