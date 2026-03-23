//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import FactoryKit

// MARK: - Protocol

@MainActor
protocol MeasurementDetailViewModelProtocol: AnyObject, Observable {
    
    // MARK: - Properties
    
    var state: FetchState<String> { get }
    var error: AppError? { get }
    
    
    var context: MeasurementTypesDestinations.Context { get set }
    var timeRange: TimeRange { get set }
    
    // MARK: - Methods

}

// MARK: - Implementation

@MainActor
@Observable final class MeasurementDetailViewModel: MeasurementDetailViewModelProtocol {

    // MARK: - Properties

    private(set) var state: FetchState<String>
    private(set) var error: AppError?
    
    var context: MeasurementTypesDestinations.Context
    var timeRange: TimeRange

    // MARK: - Lifecycle
    
    init(
        state: FetchState<String> = .idle,
        error: AppError? = nil,
        context: MeasurementTypesDestinations.Context,
        timeRange: TimeRange = .lastDay
    ) {
        self.state = state
        self.error = error
        self.context = context
        self.timeRange = timeRange
    }

}

// MARK: - Fetch State

extension MeasurementDetailViewModel {
    
}

// MARK: - Handle State

private extension MeasurementDetailViewModel {

}
