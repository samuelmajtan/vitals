//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
struct RootTabView: View {
    
    // MARK: - Properties
    
    @State
    private var selectedTab: RootTab = .home
    
    // MARK: - View
    
    var body: some View {
        TabView {
            ForEach(RootTab.tabs) { tab in
                Tab(tab.title, systemImage: tab.image, role: tab.role) {
                    tab.body
                }
            }
        }
        .onNavigationReceive { (tab: RootTab) in
            if tab == selectedTab {
                return .immediately
            }
            selectedTab = tab
            return .after(0.8)
        }
        .onNavigationRoute(RootTabViewRouter())
        .installAuthorizationRoot()
        .tabViewStyle(.sidebarAdaptable)
    }
   
}

// MARK: - Preview

@available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
#Preview {
    RootTabView()
}
