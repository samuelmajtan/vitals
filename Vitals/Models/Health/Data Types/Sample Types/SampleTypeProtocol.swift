//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

protocol SampleTypeProtocol: Equatable, Hashable, Identifiable {

    var title: String { get }
    var type: SampleType { get }
    var category: SampleCategory { get }
    var config: SampleConfiguration { get }

}
