//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

extension Date {

    /// Calculates the difference between the current date and a given date for specified components.
    ///
    /// - Parameters:
    ///   - components: A set of `Calendar.Component` values specifying which components to calculate (e.g., `.day`, `.month`).
    ///   - to: The target date to compare to.
    /// - Returns: A `DateComponents` object containing the calculated difference for the specified components.
    func components(_ components: Set<Calendar.Component>, to: Date) -> DateComponents {
        Calendar.current.dateComponents(components, from: self, to: to)
    }

}

extension Date {

    static var hourlyInterval: DateInterval {
        let end = Calendar.current.startOfDay(for: Date())
        let start = Calendar.current.date(byAdding: .hour, value: -1, to: end)!
        return DateInterval(start: start, end: end)
    }

    static var dailyInterval: DateInterval {
        let end = Calendar.current.startOfDay(for: Date())
        let start = Calendar.current.date(byAdding: .day, value: -1, to: end)!
        return DateInterval(start: start, end: end)
    }

    static var weeklyInterval: DateInterval {
        let end = Calendar.current.startOfDay(for: Date())
        let start = Calendar.current.date(byAdding: .day, value: -7, to: end)!
        return DateInterval(start: start, end: end)
    }

    static var monthlyInterval: DateInterval {
        let end = Calendar.current.startOfDay(for: Date())
        let start = Calendar.current.date(byAdding: .month, value: -1, to: end)!
        return DateInterval(start: start, end: end)
    }

    static var yearlyInterval: DateInterval {
        let end = Calendar.current.startOfDay(for: Date())
        let start = Calendar.current.date(byAdding: .year, value: -1, to: end)!
        return DateInterval(start: start, end: end)
    }
    
}
