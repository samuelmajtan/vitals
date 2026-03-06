//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

protocol Displayable {

    var title: String { get }

}

extension Displayable where Self: CustomStringConvertible {

    var description: String {
        title
    }

}
