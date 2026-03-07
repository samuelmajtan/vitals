//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import FactoryKit

// MARK: - Protocol

@MainActor
protocol MeasurementsViewModelProtocol: AnyObject, Observable {
    
    // MARK: - Properties
    
    var state: FetchState<EmptyResponse> { get }
    var error: AppError? { get }
    
    // MARK: - Methods
    
}

// MARK: - Implementation

@MainActor
@Observable final class MeasurementsViewModel: MeasurementsViewModelProtocol {

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

extension MeasurementsViewModel {

}

// MARK: - Handle State

private extension MeasurementsViewModel {

    func handleState(_ state: FetchState<EmptyResponse>) {
        self.state = state
        
        if let error = try? state.unwrapFailure() {
            self.error = error
        }
    }

}
