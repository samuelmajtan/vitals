//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import NavigatorUI
import SwiftUI

enum RootTab: Equatable, Hashable {
    
    case home
    case health
    case search
    
}

extension RootTab {

    static var tabs: [RootTab] {
        [.home, .health, .search]
    }

    var title: String {
        switch self {
        case .home:
            "Home"
        case .health:
            "Health"
        case .search:
            "Search"
        }
    }

    var image: String {
        switch self {
        case .home:
            SF.home.rawValue
        case .health:
            SF.health.rawValue
        case .search:
            SF.search.rawValue
        }
    }
    
    var role: TabRole? {
        if case .search = self {
            return TabRole.search
        }
        return nil
    }

}

extension RootTab: NavigationDestination {

    var body: some View {
        switch self {
        case .home:
            HomeScreen()
        case .health:
            HealthScreen()
        case .search:
            SearchScreen()
        }
    }

}

// MARK: - Identifiable

extension RootTab: Identifiable {

    var id: String {
        "\(self)"
    }

}
