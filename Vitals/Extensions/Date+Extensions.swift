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
