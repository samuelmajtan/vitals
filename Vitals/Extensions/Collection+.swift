//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

extension Collection {

    var isNotEmpty: Bool {
        !isEmpty
    }

    var asArray: [Element] {
        Array(self)
    }

    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

}
