//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

extension String {

    /// Returns a normalized version of the string by trimming whitespace, converting to lowercase, and removing diacritics.
    ///
    /// - Returns: A trimmed, lowercased, and diacritic-insensitive string.
    func normalize() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .folding(options: .diacriticInsensitive, locale: nil)
    }

    /// Truncates the string to a specified maximum length, appending a trailing string if needed.
    ///
    /// - Parameters:
    ///   - length: The total maximum length of the resulting string, including the trailing string.
    ///   - trailing: A string to append to the truncated string (default is "…").
    /// - Returns: The original string if it's within the limit, or a truncated version with the trailing string.
    func truncate(length: Int, trailing: String = "…") -> String {
        let maxLength = length - trailing.count
        guard maxLength > 0, !self.isEmpty, self.count > length else {
            return self
        }
        return self.prefix(maxLength) + trailing
    }

}
