//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

protocol Searchable {
   
    var searchResults: [String] { get }
    var searchText: String { get set }

}
