//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct AnyChartDataSource: ChartDataSource {
    
    private let _date: () -> Date
    private let _value: () -> Double
    let id: UUID
    
    var date: Date { _date() }
    var value: Double { _value() }
    
    init<T: ChartDataSource>(_ base: T) {
        _date = { base.date }
        _value = { base.value }
        id = base.id
    }
    
}

extension AnyChartDataSource: Equatable, Hashable {
    
    static func == (lhs: AnyChartDataSource, rhs: AnyChartDataSource) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
