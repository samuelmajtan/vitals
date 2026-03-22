//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

/// Represents the overall authorization state of the application.
enum AppState: Codable, Equatable, Hashable, Sendable {
    
    /// Indicates that the user is successfully authorized.
    case authorized
    /// The app is determining its current state (e.g., during startup).
    case unknown
    
}
