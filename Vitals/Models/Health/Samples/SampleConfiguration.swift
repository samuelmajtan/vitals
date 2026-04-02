//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

struct SampleConfiguration {
    let statistics: SampleStatisticsOptions
    let chartStyle: ChartStyle
    let summaryLabel: SummaryLabel
    let dateInterval: DateInterval
    let barUnit: Calendar.Component

    init(
        _ statistics: SampleStatisticsOptions,
        chartStyle: ChartStyle,
        summaryLabel: SummaryLabel = .range,
        dateInterval: DateInterval,
        barUnit: Calendar.Component = .day
    ) {
        self.statistics   = statistics
        self.chartStyle   = chartStyle
        self.summaryLabel = summaryLabel
        self.dateInterval = dateInterval
        self.barUnit      = barUnit
    }
}
