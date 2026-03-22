//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import FactoryKit

// MARK: - Protocol

@MainActor
protocol MeasurementTypesViewModelProtocol: AnyObject, Observable {
    
    // MARK: - Properties
    
    var state: FetchState<String> { get }
    var error: AppError? { get }
    
    var context: MeasurementsDestinations.Context { get set }
    
    // MARK: - Methods
    
}

// MARK: - Implementation

@MainActor
@Observable final class MeasurementTypesViewModel: MeasurementTypesViewModelProtocol {
    
    // MARK: - Properties
    
    private(set) var state: FetchState<String>
    private(set) var error: AppError?
    
    var context: MeasurementsDestinations.Context
    
    // MARK: - Lifecycle
    
    init(
        state: FetchState<String> = .idle,
        error: AppError? = nil,
        _ context: MeasurementsDestinations.Context
    ) {
        self.state = state
        self.error = error
        self.context = context
    }
    
}

// MARK: - Fetch State

extension MeasurementTypesViewModel {
    
}

// MARK: - Handle State

private extension MeasurementTypesViewModel {
    
}
