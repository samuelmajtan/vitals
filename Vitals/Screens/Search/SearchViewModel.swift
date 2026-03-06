//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import NavigatorUI
import FactoryKit

// MARK: - Protocol

@MainActor
protocol SearchViewModelProtocol: AnyObject, Observable {

    // MARK: - Properties

    var state: FetchState<EmptyResponse> { get }
    var error: AppError? { get }

    // MARK: - Methods

}

// MARK: - Implementation

@MainActor
@Observable final class SearchViewModel: SearchViewModelProtocol {

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

extension SearchViewModel {
    
}

// MARK: - Handle State

private extension SearchViewModel {
    
}
