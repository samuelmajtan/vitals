//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

extension DateFormatter {

    private static let dateFormatter = DateFormatter()

    enum DateFormat: String {

        case yyyyMMdd = "yyyy-MM-dd"
        case ddMMyyyy = "dd.MM.yyyy"
        case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
        case ddMMyyyyHHmmss = "dd.MM.yyyy HH:mm:ss"
        case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
        case HHmm = "HH:mm"
        case dMMMyyyy = "d MMM yyyy"
        case dMMM = "d MMM"
        case d = "d"
        case MMMyyyy = "MMM yyyy"

    }

    /// Returns a string representation of the given `Date` using the specified `DateFormat`.
    ///
    /// - Parameters:
    ///   - date: The `Date` object to format.
    ///   - format: The `DateFormat` to use.
    /// - Returns: A string representing the formatted date.
    static func dateString(date: Date, format: DateFormat) -> String {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }

    /// Parses a string into a `Date` object using the specified `DateFormat`.
    ///
    /// - Parameters:
    ///   - string: The date string to parse.
    ///   - format: The `DateFormat` to use.
    /// - Returns: A `Date` object if parsing succeeds, or `nil` if it fails.
    static func date(from string: String, format: DateFormat) -> Date? {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: string)
    }

}
