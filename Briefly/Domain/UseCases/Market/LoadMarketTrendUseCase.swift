//
//  LoadMarketTrendUseCase.swift
//  Briefly
//
//  Created by Pranay Chander on 17/02/26.
//

import Foundation

protocol LoadMarketTrendUseCase {
    func execute(
        symbol: String,
        interval: MarketInterval,
        limit: Int?,
        dividend: Bool?
    ) async throws -> [ChartPoint]
}

final class DefaultLoadMarketTrendUseCase: LoadMarketTrendUseCase {
    private let repository: MarketRepository

    init(repository: MarketRepository) {
        self.repository = repository
    }

    func execute(
        symbol: String,
        interval: MarketInterval,
        limit: Int?,
        dividend: Bool?
    ) async throws -> [ChartPoint] {
        try await repository.fetchMarketTrend(
            symbol: symbol,
            interval: interval,
            limit: limit,
            dividend: dividend
        )
    }
}
