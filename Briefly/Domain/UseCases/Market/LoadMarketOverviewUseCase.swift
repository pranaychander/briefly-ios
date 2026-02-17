//
//  LoadMarketOverviewUseCase.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import Foundation

protocol LoadMarketOverviewUseCase {
    func execute() async throws -> MarketOverview
}

final class DefaultLoadMarketOverviewUseCase: LoadMarketOverviewUseCase {

    private let repository: MarketRepository

    init(repository: MarketRepository) {
        self.repository = repository
    }

    func execute() async throws -> MarketOverview {
        async let indices = repository.fetchIndices()
        async let gainers = repository.fetchTopGainers()
        async let losers = repository.fetchTopLosers()
        async let chart = repository.fetchMarketTrend()

        return try await MarketOverview(
            indices: indices,
            gainers: gainers,
            losers: losers,
            chart: chart
        )
    }
}
