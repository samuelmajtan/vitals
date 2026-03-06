//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

/// A unified error type representing high-level application errors.
enum AppError: Error, Equatable {
    
    /// A data parsing or decoding error with an associated message.
    case parsing(String)
    /// An unspecified or unknown error, optionally with context.
    case unknown(String?)
    
}
