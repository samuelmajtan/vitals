//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI
import NavigatorUI
import HealthKitUI
import FactoryKit

struct AuthorizationRootModifier: ViewModifier {
    
    @Environment(\.navigator)
    private var navigator: Navigator
    @Injected(\.healthService)
    private var healthService
    @State
    private var trigger: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if healthService.isAvailable() {
                    trigger.toggle()
                }
            }
            .healthDataAccessRequest(
                store: healthService.healthStore,
                readTypes: healthService.readTypes,
                trigger: trigger
            ) { @Sendable result in
                switch result {
                case .success(_):
                    print("Health data request was successful")
                case .failure(let failure):
                    fatalError("An error occurred while requesting authentication: \(failure)")
                }
            }
    }
    
}
