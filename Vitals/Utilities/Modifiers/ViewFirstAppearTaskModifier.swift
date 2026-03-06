//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

/// A view modifier that executes an asynchronous closure only the first time the view appears.
///
/// This modifier triggers the provided asynchronous action when the view first appears on the screen.
/// The action is executed only once, and subsequent appearances do not trigger it again.
///
/// - Parameters:
///   - action: An asynchronous closure to perform when the view first appears.
/// - Returns: A modified view that executes the asynchronous action on first appearance.
struct ViewFirstAppearTaskModifier: ViewModifier {

    // MARK: - Properties

    @State
    private var didAppear = false
    private let action: AsyncVoidClosure

    // MARK: - Lifecycle

    init(perform action: @escaping AsyncVoidClosure) {
        self.action = action
    }

    // MARK: - View

    func body(content: Content) -> some View {
        content.task {
            if !didAppear {
                didAppear.toggle()
                await action()
            }
        }
    }

}
