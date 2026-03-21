//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI
import NavigatorUI
 
struct AuthorizationRootModifier: ViewModifier {
    
    @Environment(\.navigator)
    private var navigator: Navigator

    func body(content: Content) -> some View {
        content
    }

}
