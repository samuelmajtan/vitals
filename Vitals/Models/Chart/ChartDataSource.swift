//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

protocol ChartDataSource: Equatable, Hashable, Identifiable {

    var date: Date { get }
    var value: Double { get }
    var id: UUID { get }

}
