//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

enum SampleInterval: CaseIterable, Equatable {

    case daily
    case weekly
    case monthly

    var dateInterval: DateInterval {
        switch self {
        case .daily:
            Date.dailyInterval
        case .weekly:
            Date.weeklyInterval
        case .monthly:
            Date.monthlyInterval
        }
    }

    var title: String {
        switch self {
        case .daily:   
            "Today"
        case .weekly:  
            "Past 7 Days"
        case .monthly: 
           "Past Month"
        }
    }

}
