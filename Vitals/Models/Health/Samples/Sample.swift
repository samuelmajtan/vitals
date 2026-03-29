//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct Sample: Identifiable, Hashable, Equatable {
    
    let id: UUID
    let type: AnySampleType
    let date: Date
    let value: Double
    let unit: String
    let interval: SampleInterval
    
    init(
        _ type: AnySampleType,
        date: Date,
        value: Double,
        unit: String,
        interval: SampleInterval
    ) {
        self.id       = UUID()
        self.type     = type
        self.date     = date
        self.value    = value
        self.unit     = unit
        self.interval = interval
    }
    
}
