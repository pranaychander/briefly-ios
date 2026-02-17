//
//  MarketTrendScreen.swift
//  Briefly
//
//  Created by Pranay Chander on 17/02/26.
//

import SwiftUI

struct MarketTrendScreen: View {
    @State var viewModel: MarketTrendViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Market Trend")
                        .font(.headline)
                    Text(viewModel.selectedIndexName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Picker("Index", selection: $viewModel.selectedIndex) {
                    ForEach(viewModel.indices, id: \.symbol) { item in
                        Text(item.name).tag(item.symbol)
                    }
                }
                .pickerStyle(.menu)
                .disabled(viewModel.isLoading)
            }

            ZStack {
                MarketTrendChartView(data: viewModel.points)
                    .frame(height: 180)
                    .opacity(viewModel.isLoading ? 0.35 : 1.0)

                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 6) {
                        Text("Couldn’t load data")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(12)
                }
            }

            Picker("Interval", selection: $viewModel.selectedInterval) {
                ForEach(MarketInterval.allCases) { interval in
                    Text(interval.label.uppercased()).tag(interval)
                }
            }
            .pickerStyle(.segmented)
            .disabled(viewModel.isLoading)
        }
        .padding(12)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .task {
            await viewModel.load()
        }
        .onChange(of: viewModel.selectedIndex) { _, _ in
            Task { await viewModel.load() }
        }
        .onChange(of: viewModel.selectedInterval) { _, _ in
            Task { await viewModel.load() }
        }
    }
}
