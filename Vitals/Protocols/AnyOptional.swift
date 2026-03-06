//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

/// A type-erased protocol that provides a uniform way of checking whether an optional value is `nil`.
protocol AnyOptional {

    var isNil: Bool { get }

    var isNotNil: Bool { get }

}
