//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct SampleData: ChartDataSource {
  
    let date: Date
    let value: Double

}

extension SampleData: Identifiable {

    var id: UUID {
        UUID()
    }

}
