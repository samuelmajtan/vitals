//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

enum SampleChartOptions {

    case bar
    case line
    case sector

}

extension SampleChartOptions: Identifiable {

    var id: Self {
        self
    }

}
