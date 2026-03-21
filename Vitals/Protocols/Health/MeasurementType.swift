//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

protocol MeasurementType: Equatable, Hashable, Identifiable {
    
    var title: String { get }
    var identifier: MeasurementTypeIdentifier { get }

}

