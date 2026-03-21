//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI

struct ChevronButton: View {
    
    // MARK: - Properties
    
    private let title: String
    private let image: String?
    private let color: Color?
    private let action: VoidClosure
    
    // MARK: - Lifecycle
    
    init(
        _ title: String,
        image: String,
        color: Color? = nil,
        action: @escaping VoidClosure
    ) {
        self.title = title
        self.image = image
        self.color = color
        self.action = action
    }
    
    // MARK: - View
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    if let image {
                        Image(systemName: image)
                            .foregroundStyle(color ?? .accent)
                    }
                    Text(title)
                        .foregroundStyle(.primary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
    }
    
}

// MARK: - Preview

#Preview {
    ChevronButton("Title", image: "heart", color: .blue) {
        print("Navigating to...")
    }
}
