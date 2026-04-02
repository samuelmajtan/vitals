//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct SampleData: Identifiable, Equatable {

    let id: UUID
    let date: Date
    let value: Double
    let min: Double?
    let max: Double?

    init(date: Date, value: Double, min: Double? = nil, max: Double? = nil) {
        self.id    = UUID()
        self.date  = date
        self.value = value
        self.min   = min
        self.max   = max
    }

}
