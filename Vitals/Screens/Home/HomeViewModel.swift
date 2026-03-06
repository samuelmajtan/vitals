//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import FactoryKit
import SwiftUI

@MainActor
protocol HomeViewModelProtocol: AnyObject, Observable {
   
    // MARK: - Properties

    var state: FetchState<EmptyResponse> { get }
    var error: AppError? { get }

    // MARK: - Methods

}

@MainActor
@Observable final class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Services

    // MARK: - Properties
    
    private(set) var state: FetchState<EmptyResponse>
    private(set) var error: AppError?

    // MARK: - Lifecycle
    
    init(state: FetchState<EmptyResponse> = .idle, error: AppError? = nil) {
        self.state = state
        self.error = error
    }

}

// MARK: - Fetch State

extension HomeViewModel {


}

// MARK: - Handle State

private extension HomeViewModel {

}
