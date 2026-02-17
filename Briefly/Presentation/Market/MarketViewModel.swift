//
//  MarketViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import Foundation

@MainActor
@Observable
final class MarketViewModel {

    private let loadMarketOverview: LoadMarketOverviewUseCase
    let loadMarketTrend: LoadMarketTrendUseCase

    init(loadMarketOverview: LoadMarketOverviewUseCase, loadMarketTrend: LoadMarketTrendUseCase) {
        self.loadMarketOverview = loadMarketOverview
        self.loadMarketTrend = loadMarketTrend
    }

    var indices: [MarketIndex] = []
    var gainers: [Stock] = []
    var losers: [Stock] = []
    var chartData: [ChartPoint] = []

    var selectedMoverType: MoverType = .gainers

    var visibleMovers: [Stock] {
        selectedMoverType == .gainers ? gainers : losers
    }

    func load() async {
        do {
            let overview = try await loadMarketOverview.execute()
            indices = overview.indices
            gainers = overview.gainers
            losers = overview.losers
            chartData = overview.chart
        } catch {
            print("Market load failed:", error)
        }
    }
}
