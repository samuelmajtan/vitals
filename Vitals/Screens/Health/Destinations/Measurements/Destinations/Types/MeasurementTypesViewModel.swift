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

    var context: MeasurementsDestinations.Context { get }

    var dailySamples: [Sample] { get }
    var weeklySamples: [Sample] { get }
    var monthlySamples: [Sample] { get }
    var emptySamples: [Sample] { get }

    // MARK: - Methods

}

// MARK: - Implementation

@MainActor
@Observable final class MeasurementTypesViewModel: MeasurementTypesViewModelProtocol {

    // MARK: - Services

    @ObservationIgnored
    @Injected(\.healthService)
    private var healthService: HealthServiceProtocol

    // MARK: - Properties

    private(set) var state: FetchState<String>
    private(set) var error: AppError?

    private(set) var context: MeasurementsDestinations.Context

    private(set) var dailySamples: [Sample] = []
    private(set) var weeklySamples: [Sample] = []
    private(set) var monthlySamples: [Sample] = []
    private(set) var emptySamples: [Sample] = []

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
    
    func fetchSamples() async {
    }
    
}

// MARK: - Handle State

private extension MeasurementTypesViewModel {
    
}
