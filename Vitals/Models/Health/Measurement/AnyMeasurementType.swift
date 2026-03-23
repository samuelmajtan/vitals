//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct AnyMeasurementType: MeasurementTypeProtocol {

    private let _title: () -> String
    private let _type: () -> MeasurementType
    private let _id: AnyHashable
    
    var title: String { _title() }
    var type: MeasurementType { _type() }
    var id: AnyHashable { _id }
    
    init<T: MeasurementTypeProtocol>(_ base: T) {
        _title = { base.title }
        _type = { base.type }
        _id = AnyHashable(base.id)
    }

}

extension AnyMeasurementType: Equatable, Hashable {

    static func == (lhs: AnyMeasurementType, rhs: AnyMeasurementType) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
