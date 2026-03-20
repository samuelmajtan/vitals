//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct PrimaryButton: View {

    // MARK: - Properties

    private let title: String
    private let isLoading: Bool
    private let action: VoidClosure

    // MARK: - Lifecycle

    init(
        title: String,
        isLoading: Bool = false,
        action: @escaping VoidClosure
    ) {
        self.title = title
        self.isLoading = isLoading
        self.action = action
    }

    // MARK: - View

    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(title)
            }
        }
        .buttonStyle(.primary)
        .disabled(isLoading)
    }

}

// MARK: - Style

struct PrimaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .padding(.vertical, Constant.Spacing.lg)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(
                configuration.isPressed
                ? Color.Palette.red3
                : Color.Palette.red5
            )
            .cornerRadius(Constant.CornerRadius.sm)
    }

}

extension ButtonStyle where Self == PrimaryButtonStyle {

    static var primary: PrimaryButtonStyle {
        .init()
    }

}

// MARK: - Preview

#Preview {
    Group {
        PrimaryButton(title: "Title A", isLoading: false, action: {})
        PrimaryButton(title: "Title B", isLoading: true, action: {})
    }
}
