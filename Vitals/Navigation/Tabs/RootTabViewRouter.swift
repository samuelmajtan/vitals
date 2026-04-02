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
        case .authorization:
            navigator.perform(
                .reset,
                .send(RootTab.home),
                .authorizationRequired,
            )
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
        case .insights:
            navigator.perform(
                .reset,
                .send(RootTab.insights)
            )
        case .search:
            navigator.perform(
                .reset,
                .send(RootTab.search)
            )
        }
    }
    
}
