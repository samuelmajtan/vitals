//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

extension URL {

    init(_ staticString: StaticString) throws(URLError) {
        guard let url = Self(string: "\(staticString)") else {
            throw URLError(.badURL)
        }
        self = url
    }

}
