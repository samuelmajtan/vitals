//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

enum NetworkError: Equatable, LocalizedError {

    case invalidURL
    case badRequest
    case httpError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString(
                "The URL is invalid.",
                comment: "Shown when the app fails to create a valid URL for a network request."
            )
            
        case .badRequest:
            return NSLocalizedString(
                "The request could not be created.",
                comment: "Shown when a network request cannot be formed correctly before sending it."
            )
            
        case .httpError(let statusCode):
            return String(
                format: NSLocalizedString(
                    "The server returned an error (code %d).",
                    comment: "Shown when the server responds with an HTTP error status code. %d is the status code."
                ),
                statusCode
            )
        }
    }

}
