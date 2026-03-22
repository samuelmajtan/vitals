//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct GradientView: View {
    
    // MARK: - Properties

    let color: Color
     
    // MARK: - Lifecycle

    init(color: Color) {
        self.color = color
    }
    
    // MARK: - View

    var body: some View {
        Color.black.ignoresSafeArea(.all)
        LinearGradient(
            gradient: Gradient(colors: [color.opacity(0.4), Color.clear]),
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(height: 250)
        .ignoresSafeArea()
    }

}

// MARK: - Preview

#Preview {
    GradientView(color: .blue)
}
