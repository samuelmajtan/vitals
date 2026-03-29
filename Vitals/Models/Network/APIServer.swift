//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

enum APIServer {
    
    case base
    
    var rawValue: String {
        switch self {
        case .base:
            return "http://127.0.0.1:8080"
        }
    }
    
}
