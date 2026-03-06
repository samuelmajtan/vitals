//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

enum FetchState<Success>: Equatable, Sendable where Success: Equatable & Sendable {
    
    case idle
    case loading
    case failure(AppError)
    case success(Success)
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var isLoadingOrIdle: Bool {
        if case .loading = self {
            return true
        } else if case .idle = self {
            return true
        }
        return false
    }
    
    var isIdle: Bool {
        if case .idle = self {
            return true
        }
        return false
    }
    
    var isFailure: Bool {
        if case .failure = self {
            return true
        }
        return false
    }
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
    
    var isFinished: Bool {
        isSuccess || isFailure
    }
    
    func unwrapSuccess() throws -> Success {
        if case let .success(value) = self {
            return value
        } else {
            throw AppError.parsing("Response could not be unwrapped.")
        }
    }
    
    func unwrapFailure() throws -> AppError {
        if case let .failure(error) = self {
            return error
        } else {
            throw AppError.parsing("Response could not be unwrapped.")
        }
    }
    
    var successValue: Success? {
        if case .success(let successValue) = self {
            return successValue
        }
        return nil
    }
    
}

extension Result where Success: Equatable & Sendable, Failure == AppError {
    
    func asFetchState() -> FetchState<Success> {
        switch self {
        case .success(let success):
            return .success(success)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
