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
    var context: MeasurementTypesDestinations.Context { get }

    var timeRange: TimeRange { get set }
    var sampleData: [SampleData] { get set }

    // MARK: - Methods

    func fetchSamples() async

}

// MARK: - Implementation

@MainActor
@Observable final class MeasurementDetailViewModel: MeasurementDetailViewModelProtocol {

    // MARK: - Services

    @ObservationIgnored
    @Injected(\.healthService)
    private var healthService: HealthServiceProtocol

    // MARK: - Properties

    private(set) var state: FetchState<String>
    private(set) var error: AppError?
    private(set) var context: MeasurementTypesDestinations.Context

    var timeRange: TimeRange = .lastDay
    var sampleData: [SampleData] = []

    // MARK: - Lifecycle
    
    init(
        state: FetchState<String> = .idle,
        error: AppError? = nil,
        _ context: MeasurementTypesDestinations.Context,
    ) {
        self.state = state
        self.error = error
        self.context = context
    }

}

// MARK: - Fetch State

extension MeasurementDetailViewModel {

    func fetchSamples() async {
        let sampleType = context.sample.type
        let interval = timeRange.dateInterval
        
        if let result = try? await healthService.fetchSampleData(for: sampleType, in: interval, limit: nil) {
           sampleData = result
        }
    }

}

// MARK: - Handle State

private extension MeasurementDetailViewModel {

}
