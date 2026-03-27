//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

extension Double {

    var shortFormatted: String {
        self.formatted(.number.precision(.fractionLength(0...1)))
    }

}
