//
//  MarketView.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import SwiftUI
import Charts

struct MarketView: View {

    @State var viewModel: MarketViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                Text("Live market overview and trends")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                IndicesRowView(indices: viewModel.indices)

                MarketTrendChartView(data: viewModel.chartData)

                MoversPickerView(
                    selection: $viewModel.selectedMoverType
                )

                MoversListView(stocks: viewModel.visibleMovers)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Markets")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.load()
        }
    }
}
