//
//  MarketTrendChartView.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import SwiftUI
import Charts

struct MarketTrendChartView: View {
    let data: [ChartPoint]

    var body: some View {
        Chart(data) {
            LineMark(
                x: .value("Time", $0.time),
                y: .value("Value", $0.value)
            )
            .interpolationMethod(.catmullRom)
        }
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 4)) { value in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.hour().minute())
            }
        }
    }
}
