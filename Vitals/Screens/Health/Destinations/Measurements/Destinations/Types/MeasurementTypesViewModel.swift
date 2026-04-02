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
    var emptySamples: [AnySampleType] { get }
    
    // MARK: - Methods

    func fetchSamples() async
    func fetchSampleData(for type: AnySampleType) async -> [SampleData]

}

// MARK: - Implementation

@MainActor
@Observable final class MeasurementTypesViewModel: MeasurementTypesViewModelProtocol {

    // MARK: - Services

    @ObservationIgnored
    @Injected(\.healthService)
    private var healthService: HealthServiceProtocol

    // MARK: - Properties
    
    private(set) var state: FetchState<String> = .idle
    private(set) var error: AppError?
    private(set) var context: MeasurementsDestinations.Context
    
    private(set) var dailySamples: [Sample]     = []
    private(set) var weeklySamples: [Sample]    = []
    private(set) var monthlySamples: [Sample]   = []
    private(set) var emptySamples: [AnySampleType] = []
    
    // MARK: - Lifecycle
    
    init(_ context: MeasurementsDestinations.Context) {
        self.context = context
    }

}

// MARK: - Fetch State

extension MeasurementTypesViewModel {
    
    func fetchSamples() async {
        
        let types = context.category.types
        
        await withTaskGroup(of: (AnySampleType, Sample?).self) { group in
            for type in types {
                group.addTask { [weak self] in
                    guard let self else { return (type, nil) }
                    let sample = try? await self.healthService.fetchSample(for: type)
                    return (type, sample)
                }
            }
            
            var daily: [Sample] = []
            var weekly: [Sample] = []
            var monthly: [Sample] = []
            var empty: [AnySampleType] = []
            
            for await (type, sample) in group {
                switch sample?.interval {
                case .daily:   daily.append(sample!)
                case .weekly:  weekly.append(sample!)
                case .monthly: monthly.append(sample!)
                case nil:      empty.append(type)
                }
            }
            
            let order = types.enumerated().reduce(into: [AnyHashable: Int]()) { $0[$1.element.id] = $1.offset }
            self.dailySamples = daily.sorted { (order[$0.type.id] ?? 0) < (order[$1.type.id] ?? 0) }
            self.weeklySamples = weekly.sorted { (order[$0.type.id] ?? 0) < (order[$1.type.id] ?? 0) }
            self.monthlySamples = monthly.sorted { (order[$0.type.id] ?? 0) < (order[$1.type.id] ?? 0) }
            self.emptySamples = empty.sorted { (order[$0.id] ?? 0) < (order[$1.id] ?? 0) }
            
        }
        
    }
    
    func fetchSampleData(for type: AnySampleType) async -> [SampleData] {
        (try? await healthService.fetchSampleData(for: type, in: type.config.dateInterval, limit: nil)) ?? []
    }
}
