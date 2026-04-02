//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI
import AnalysisKit

/// Describes a metric to display on the Home dashboard.
struct HomeMetric: Identifiable, Equatable {
    
    let id: UUID = UUID()
    let title: String
    let image: String
    let color: Color
    let value: String
    let unit: String
    let trend: TrendDirection?
    let category: SampleCategory
    
    static func == (lhs: HomeMetric, rhs: HomeMetric) -> Bool {
        lhs.id == rhs.id
    }
    
}
