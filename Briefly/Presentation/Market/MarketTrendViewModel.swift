//
//  MarketTrendViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 17/02/26.
//

import Foundation

@MainActor
@Observable
final class MarketTrendViewModel {
    let indices: [(symbol: String, name: String)] = [
        ("^GSPC", "S&P 500"),
        ("^DJI", "Dow Jones"),
        ("^NDX", "Nasdaq 100"),
        ("^VIX", "Volatility Index")
    ]

    private let loadMarketTrend: LoadMarketTrendUseCase

    var selectedIndex: String
    var selectedInterval: MarketInterval
    var points: [ChartPoint]
    var errorMessage: String?
    var isLoading = false

    init(
        points: [ChartPoint],
        loadMarketTrend: LoadMarketTrendUseCase,
        selectedIndex: String = "^DJI",
        selectedInterval: MarketInterval = .oneWeek
    ) {
        self.points = points
        self.loadMarketTrend = loadMarketTrend
        self.selectedIndex = selectedIndex
        self.selectedInterval = selectedInterval
    }

    func load() async {
        do {
            isLoading = true
            errorMessage = nil
            points = try await loadMarketTrend.execute(
                symbol: selectedIndex,
                interval: selectedInterval,
                limit: selectedInterval.apiLimit,
                dividend: nil
            )
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    var selectedIndexName: String {
        indices.first(where: { $0.symbol == selectedIndex })?.name ?? ""
    }
}
