//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import Defaults

struct LoginResponse: Encodable, Responsable, Storable {
   
    let token: String
    let roles: [Role]

}

enum Role: String, Codable, Equatable {
    
    case patient = "PATIENT"
    case doctor = "DOCTOR"
    case admin = "ADMIN"
    
}
