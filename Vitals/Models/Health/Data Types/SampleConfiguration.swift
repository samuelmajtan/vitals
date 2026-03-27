//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct SampleConfiguration {

    let statistics: SampleStatisticsOptions
    let chart: SampleChartOptions
    let dateInterval: DateInterval

    init(_ statistics: SampleStatisticsOptions, chart: SampleChartOptions, dateInterval: DateInterval) {
        self.statistics = statistics
        self.chart = chart
        self.dateInterval = dateInterval
    }

}
