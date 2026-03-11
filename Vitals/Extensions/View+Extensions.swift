//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

extension View {
    
    /// Performs an action when the view appears for the first time.
    ///
    /// - Parameter action: A closure executed once when the view first appears.
    /// - Returns: A modified view that triggers the action on its first appearance.
    func onFirstAppear(perform action: (VoidClosure)? = nil) -> some View {
        modifier(ViewFirstAppearModifier(perform: action))
    }
    
    /// Performs an async action when the view appears for the first time.
    ///
    /// - Parameter action: An asynchronous closure executed once when the view first appears.
    /// - Returns: A modified view that triggers the async action on its first appearance.
    func onFirstAppearTask(perform action: (@Sendable @escaping () async -> Void)) -> some View {
        modifier(ViewFirstAppearTaskModifier(perform: action))
    }
    
}

extension View {
    
    /// Applies a redacted effect to the view when the given condition is `true`.
    ///
    /// This method redacts the view using `.placeholder`, removes color saturation,
    /// and disables user interactions.
    ///
    /// - Parameter condition: A Boolean value that determines whether the view should be redacted.
    /// - Returns: A modified view with the redacted effect applied if `condition` is `true`.
    @ViewBuilder
    func redacted(if condition: Bool) -> some View {
        condition
        ? AnyView(redacted(reason: .placeholder).saturation(.zero).disabled(true))
        : AnyView(self)
    }
    
}

extension View {
    
    /// Prints the given values to the console and returns an `EmptyView`.
    ///
    /// Useful for debugging in SwiftUI view bodies.
    ///
    /// - Parameter vars: Values to print.
    func printDebug(_ vars: Any...) -> some View {
        for value in vars { print(value) }
        return EmptyView()
    }
    
}
