//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

protocol MeasurementTypeProtocol: Equatable, Hashable, Identifiable {
    
    var title: String { get }
    var type: MeasurementType { get }

}

