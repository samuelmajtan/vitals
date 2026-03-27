//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct Sample {

    let type: AnySampleType
    let date: Date
    let value: Double
    let unit: String

    init(_ type: AnySampleType, date: Date, value: Double, unit: String) {
        self.type = type
        self.date = date
        self.value = value
        self.unit = unit
    }

}

extension Sample: Identifiable {

    var id: AnySampleType {
        self.type
    }

}
