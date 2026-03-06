//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

extension Data {

    /// Decodes the `Data` into the specified `Decodable` type using `JSONDecoder`.
    ///
    /// - Returns: A decoded instance of type `T`.
    /// - Throws: An error if decoding fails.
    ///
    /// Example:
    /// ```swift
    /// let user: User = try jsonData.decoded()
    /// ```
    func decoded<T>() throws -> T where T: Decodable {
        try JSONDecoder().decode(T.self, from: self)
    }

}
