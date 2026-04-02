//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

enum SummaryLabel {
   
    case range
    case average
    case total
    case latest
  
    var title: String {
        switch self {
        case .range:    
            return "Range"
        case .average:
            return "Average"
        case .total:    
            return "Total"
        case .latest:   
            return "Latest"
        }
    }

}
