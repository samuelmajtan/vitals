//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import FactoryKit

// MARK: - Protocol

protocol AuthServiceProtocol: AnyObject {
    
}

// MARK: - Implementation

final class AuthService: AuthServiceProtocol {
    
}

// MARK: - Factory

extension Container {
    
    var authService: Factory<AuthServiceProtocol> {
        self { @MainActor in AuthService() }
            .cached
    }
    
}
