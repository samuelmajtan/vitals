//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct AnySampleType: SampleTypeProtocol {

    private let _title: () -> String
    private let _type: () -> SampleType
    private let _category: () -> SampleCategory
    private let _config: () -> SampleConfiguration
    private let _id: AnyHashable

    var title: String { _title() }
    var type: SampleType { _type() }
    var category: SampleCategory { _category() }
    var config: SampleConfiguration { _config() }
    var id: AnyHashable { _id }

    init<T: SampleTypeProtocol>(_ base: T) {
        _title = { base.title }
        _type = { base.type }
        _category = { base.category }
        _config = { base.config }
        _id = AnyHashable(base.id)
    }

}

extension AnySampleType: Equatable, Hashable {

    static func == (lhs: AnySampleType, rhs: AnySampleType) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
