//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

extension Encodable {

    /// Encodes the value into `Data` using `JSONEncoder`.
    ///
    /// - Returns: A JSON-encoded `Data` representation of the value.
    /// - Throws: An error if encoding fails.
    ///
    /// Example:
    /// ```swift
    /// let user = User(id: 1, name: "Alice")
    /// let data = try user.encoded()
    /// ```
    func encoded() throws -> Data {
        try JSONEncoder().encode(self)
    }

}

extension Encodable {

    /// Prints the current object as a pretty-printed JSON string with sorted keys.
    ///
    /// This function encodes the object to JSON using `JSONEncoder`, applying
    /// `.prettyPrinted` and `.sortedKeys` formatting options. If encoding fails,
    /// an error message is printed.
    ///
    /// - Note: The object must conform to `Encodable` for this method to work.
    func printPrettyJSON() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        guard let encodedData = try? encoder.encode(self) else {
            print("Failed to encode data")
            return
        }
        let prettyJSONString = String(decoding: encodedData, as: UTF8.self)
        print(prettyJSONString)
    }

}
