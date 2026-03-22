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
    
    var state: FetchState<String> { get }
    var error: AppError? { get }
    
    // MARK: - Methods
    
}

// MARK: - Implementation

@MainActor
@Observable final class MeasurementsViewModel: MeasurementsViewModelProtocol {

    // MARK: - Properties

    private(set) var state: FetchState<String>
    private(set) var error: AppError?

    // MARK: - Lifecycle

    init(state: FetchState<String> = .idle, error: AppError? = nil) {
        self.state = state
        self.error = error
    }

}

// MARK: - Fetch State

extension MeasurementsViewModel {

}

// MARK: - Handle State

private extension MeasurementsViewModel {

}
