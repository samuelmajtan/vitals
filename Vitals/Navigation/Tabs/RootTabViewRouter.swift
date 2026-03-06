//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//


import SwiftUI
import NavigatorUI

struct RootTabViewRouter: NavigationRouteHandling {
    
    @MainActor
    func route(to route: KnownRoutes, with navigator: Navigator) {
        switch route {
        case .home:
            navigator.perform(
                .reset,
                .send(RootTab.home)
            )
        case .health:
            navigator.perform(
                .reset,
                .send(RootTab.health)
            )
        case .search:
            navigator.perform(
                .reset,
                .send(RootTab.search)
            )
        }
    }

}
