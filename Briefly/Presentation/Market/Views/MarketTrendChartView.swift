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
        VStack(alignment: .leading, spacing: 8) {

            Text("Market Trend")
                .font(.headline)

            Chart(data) {
                LineMark(
                    x: .value("Time", $0.time),
                    y: .value("Value", $0.value)
                )
                .interpolationMethod(.catmullRom)
            }
            .frame(height: 180)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}
