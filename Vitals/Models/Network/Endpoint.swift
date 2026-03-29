//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

enum Endpoint {

    case sendMeasurements(MeasurementsRequest)

}

extension Endpoint {

    var path: String {
        switch self {
        case .sendMeasurements:
            return "patient/measurements"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .sendMeasurements:
            return .post
        }
    }

    var parameters: [String: String] {
        switch self {
        case .sendMeasurements:
            return [:]
        }
    }

    var model: Encodable? {
        switch self {
        case .sendMeasurements(let request):
            return request
        }
    }

    var isAuthorized: Bool {
        switch self {
        case .sendMeasurements:
            return true
        }
    }

}
