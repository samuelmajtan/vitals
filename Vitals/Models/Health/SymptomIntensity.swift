//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI

enum SymptomIntensity: Int, CaseIterable {

    case none = 0
    case mild = 1
    case moderate = 2
    case severe = 3
    case extreme = 4

    var title: String {
        switch self {
        case .none: 
            "😌"
        case .mild: 
            "😐"
        case .moderate: 
            "😕"
        case .severe: 
            "😡"
        case .extreme: 
            "🤯"
        }
    }

    var color: Color {
        switch self {
        case .none:
                .yellow
        case .mild:
                .green
        case .moderate:
                .teal
        case .severe:
                .indigo
        case .extreme:
                .red
        }
    }

}

extension SymptomIntensity: Identifiable {

    var id: Self {
        self
    }

}
