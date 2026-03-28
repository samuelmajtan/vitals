//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

protocol ChartDataSource: Identifiable {

    var category: String { get set }
    var value: Double { get set }

}
