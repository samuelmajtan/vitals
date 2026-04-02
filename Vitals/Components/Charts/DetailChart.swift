//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import Charts

struct DetailChart: View {

    // MARK: - Properties

    let source: [SampleData]
    let style: ChartStyle
    let unit: String
    let barUnit: Calendar.Component
    let color: Color

    // MARK: - Lifecycle

    init(
        source: [SampleData],
        style: ChartStyle,
        unit: String,
        barUnit: Calendar.Component = .day,
        color: Color = .blue
    ) {
        self.source = source
        self.style = style
        self.unit = unit
        self.barUnit = barUnit
        self.color = color
    }

    // MARK: - View

    var body: some View {
        if source.isEmpty {
            emptyChart
        } else {
            chart
        }
    }

}

// MARK: - Chart

private extension DetailChart {

    var chart: some View {
        Chart(source) { data in
            switch style {
            case .bar:
                BarMark(
                    x: .value("Date", data.date, unit: barUnit),
                    y: .value(unit, data.value)
                )
                .foregroundStyle(color.gradient)
                .cornerRadius(3)

            case .rangeBar:
                if let min = data.min, let max = data.max, min != max {
                    BarMark(
                        x: .value("Date", data.date, unit: barUnit),
                        yStart: .value(unit, min),
                        yEnd: .value(unit, max)
                    )
                    .foregroundStyle(color.gradient)
                    .cornerRadius(3)
                } else {
                    PointMark(
                        x: .value("Date", data.date),
                        y: .value(unit, data.value)
                    )
                    .foregroundStyle(color)
                    .symbolSize(20)
                }

            case .line:
                LineMark(
                    x: .value("Date", data.date),
                    y: .value(unit, data.value)
                )
                .foregroundStyle(color)
                .lineStyle(StrokeStyle(lineWidth: 2))

                PointMark(
                    x: .value("Date", data.date),
                    y: .value(unit, data.value)
                )
                .foregroundStyle(color)
                .symbolSize(source.count <= 30 ? 20 : 0)

            case .point:
                PointMark(
                    x: .value("Date", data.date),
                    y: .value(unit, data.value)
                )
                .foregroundStyle(color)
                .symbolSize(30)

            case .interpolatedLine:
                LineMark(
                    x: .value("Date", data.date),
                    y: .value(unit, data.value)
                )
                .foregroundStyle(color)
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 2))

                AreaMark(
                    x: .value("Date", data.date),
                    y: .value(unit, data.value)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    LinearGradient(
                        colors: [color.opacity(0.2), color.opacity(0.02)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .chartYAxisLabel(unit, position: .leading)
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: xAxisCount)) { value in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: xAxisFormat, centered: style == .bar || style == .rangeBar)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: .automatic(desiredCount: 5)) { value in
                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [4]))
                AxisValueLabel()
            }
        }
    }

    var xAxisCount: Int {
        switch barUnit {
        case .minute: 4
        case .hour:   6
        case .day:    min(source.count, 7)
        case .month:  6
        default:      5
        }
    }

    var xAxisFormat: Date.FormatStyle {
        switch barUnit {
        case .minute: .dateTime.hour().minute()
        case .hour:   .dateTime.hour()
        case .day:    .dateTime.day().month(.abbreviated)
        case .month:  .dateTime.month(.abbreviated)
        default:      .dateTime.day().month(.abbreviated)
        }
    }

}

// MARK: - Empty State

private extension DetailChart {

    var emptyChart: some View {
        VStack(spacing: Constant.Spacing.md) {
            Image(systemName: "chart.bar.xaxis")
                .font(.title)
                .foregroundStyle(.tertiary)
            Text("No data for this period")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Constant.Spacing.xxxl)
    }

}

// MARK: - Preview

#Preview("Bar Chart") {
    DetailChart(
        source: [
            SampleData(date: Date().addingTimeInterval(-6 * 86400), value: 8200),
            SampleData(date: Date().addingTimeInterval(-5 * 86400), value: 6500),
            SampleData(date: Date().addingTimeInterval(-4 * 86400), value: 9100),
            SampleData(date: Date().addingTimeInterval(-3 * 86400), value: 7300),
            SampleData(date: Date().addingTimeInterval(-2 * 86400), value: 5800),
            SampleData(date: Date().addingTimeInterval(-1 * 86400), value: 10200),
            SampleData(date: Date(), value: 4300),
        ],
        style: .bar,
        unit: "steps",
        barUnit: .day,
        color: .orange
    )
    .frame(height: 220)
    .padding()
}

#Preview("Range Bar") {
    DetailChart(
        source: [
            SampleData(date: Date().addingTimeInterval(-5 * 3600), value: 72, min: 60, max: 85),
            SampleData(date: Date().addingTimeInterval(-4 * 3600), value: 78, min: 65, max: 92),
            SampleData(date: Date().addingTimeInterval(-3 * 3600), value: 68, min: 58, max: 80),
            SampleData(date: Date().addingTimeInterval(-2 * 3600), value: 82, min: 70, max: 95),
            SampleData(date: Date().addingTimeInterval(-1 * 3600), value: 75, min: 62, max: 88),
        ],
        style: .rangeBar,
        unit: "BPM",
        barUnit: .hour,
        color: .red
    )
    .frame(height: 220)
    .padding()
}

#Preview("Interpolated Line") {
    DetailChart(
        source: [
            SampleData(date: Date().addingTimeInterval(-6 * 86400), value: 45),
            SampleData(date: Date().addingTimeInterval(-5 * 86400), value: 42),
            SampleData(date: Date().addingTimeInterval(-4 * 86400), value: 48),
            SampleData(date: Date().addingTimeInterval(-3 * 86400), value: 38),
            SampleData(date: Date().addingTimeInterval(-2 * 86400), value: 52),
            SampleData(date: Date().addingTimeInterval(-1 * 86400), value: 44),
            SampleData(date: Date(), value: 40),
        ],
        style: .interpolatedLine,
        unit: "ms",
        color: .teal
    )
    .frame(height: 220)
    .padding()
}

#Preview("Empty") {
    DetailChart(
        source: [],
        style: .bar,
        unit: "steps",
        color: .orange
    )
    .frame(height: 220)
    .padding()
}
