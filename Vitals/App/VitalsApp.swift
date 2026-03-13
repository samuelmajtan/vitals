//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI

@main
struct VitalsApp: App {

    @UIApplicationDelegateAdaptor(VitalsAppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(\.navigator, self.applicationNavigator())
        }
    }
    
    private func applicationNavigator() -> Navigator {
        let configuration: NavigationConfiguration = .init(
            restorationKey: nil,
            executionDelay: 0.5,
            verbosity: .info
        )
        return Navigator(configuration: configuration)
    }

}
