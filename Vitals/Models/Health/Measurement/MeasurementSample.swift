//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct MeasurementSample {
    
    let title: String
    let date: Date
    let value: Double
    let unit: String
    
    init(_ title: String, date: Date, value: Double, unit: String) {
        self.title = title
        self.date = date
        self.value = value
        self.unit = unit
    }

}
