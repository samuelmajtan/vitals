//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct MeasurementsRequest: Requestable {

    let measurements: [Measurement]

    struct Measurement: Equatable, Codable {

        let id: Int
        let values: [MeasurementValue]

        struct MeasurementValue: Equatable, Codable {
            
            let time: String
            let value: Double
            
        }

    }

}
