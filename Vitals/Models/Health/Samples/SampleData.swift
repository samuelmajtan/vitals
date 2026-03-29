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

    init(date: Date, value: Double) {
        self.id    = UUID()
        self.date  = date
        self.value = value
    }

}
