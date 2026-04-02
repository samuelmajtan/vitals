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

    var state: FetchState<String> { get }
    var error: AppError? { get }
    var searchText: String { get set }

    // MARK: - Methods

    /// Returns categories that match the current search text.
    var filteredCategories: [SampleCategory] { get }

    /// Returns the matching types for a given category.
    /// If the category title itself matched, all types are returned.
    /// Otherwise, only types whose title matches the search text are returned.
    func types(for category: SampleCategory) -> [AnySampleType]

}

// MARK: - Implementation

@MainActor
@Observable final class SearchViewModel: SearchViewModelProtocol {

    // MARK: - Properties

    private(set) var state: FetchState<String> = .idle
    private(set) var error: AppError?
    var searchText: String = ""

    // MARK: - Lifecycle

    init(state: FetchState<String> = .idle, error: AppError? = nil) {
        self.state = state
        self.error = error
    }

    // MARK: - Computed

    var filteredCategories: [SampleCategory] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        guard !query.isEmpty else {
            return SampleCategory.allCases
        }

        return SampleCategory.allCases.filter { category in
            // Category matches if its title contains the query
            if category.title.lowercased().contains(query) {
                return true
            }
            // Or if any of its types match
            return category.types.contains { type in
                type.title.lowercased().contains(query)
            }
        }
    }

    func types(for category: SampleCategory) -> [AnySampleType] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        guard !query.isEmpty else {
            return category.types
        }

        // If the category title itself matches, show all types
        if category.title.lowercased().contains(query) {
            return category.types
        }

        // Otherwise, filter types by title match
        return category.types.filter { type in
            type.title.lowercased().contains(query)
        }
    }

}
