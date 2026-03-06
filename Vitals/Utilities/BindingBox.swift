//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

/// A nil-coalescing operator for `Binding<Optional<T>>`, allowing you to bind to a non-optional value with a fallback.
///
/// This returns a `Binding<T>` where:
/// - The getter uses `lhs.wrappedValue ?? rhs`
/// - The setter **writes back to the original optional**, replacing its value
///
/// >  Note: If the original `Binding` is `nil`, the fallback is used for display,
///   but any updates will overwrite the original value.
///
/// ### Example:
/// ```swift
/// @State private var name: String? = nil
///
/// TextField("Name", text: $name ?? "Default")
/// ```
///
/// This allows a non-optional binding even though `name` is optional.
@MainActor
func ?? <T>(lhs: Binding<T?>, rhs: T) -> Binding<T> {
    Binding<T>(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
