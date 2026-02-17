//
//  MarketRepository.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import Foundation

protocol MarketRepository {
    func fetchIndices() async throws -> [MarketIndex]
    func fetchTopGainers() async throws -> [Stock]
    func fetchTopLosers() async throws -> [Stock]
    func fetchMarketTrend() async throws -> [ChartPoint]
}

final class DefaultMarketRepository: MarketRepository {

    private let client: APIClient
    private let mapper: YahooQuoteMapper
    private let secrets: APISecrets

    init(
        client: APIClient,
        mapper: YahooQuoteMapper = DefaultYahooQuoteMapper(),
        secrets: APISecrets,
    ) {
        self.client = client
        self.mapper = mapper
        self.secrets = secrets
    }

    func fetchIndices() async throws -> [MarketIndex] {

        let indices: [(symbol: String, name: String)] = [
            ("^GSPC", "S&P 500"),
            ("^DJI", "Dow Jones"),
            ("^NDX", "Nasdaq 100"),
            ("^VIX", "Volatility Index")
        ]

        let response: YahooQuoteBody =
            try await client.request(
                YahooMarketEndpoint.quotes(
                    symbols: indices.map(\.symbol),
                    apiKey: secrets.rapidAPIKey
                )
            )

        return response.body.compactMap { quote in
            guard let index = indices.first(where: { $0.symbol == quote.symbol }) else {
                return nil
            }
            return mapper.index(from: quote, name: index.name)
        }
    }

    func fetchTopGainers() async throws -> [Stock] {
        let response: YahooQuoteBody =
            try await client.request(
                YahooMarketEndpoint.screener(screen: .gainers, apiKey: secrets.rapidAPIKey)
            )

        return response.body
            .map(mapper.stock)
            .sorted { $0.changePercent > $1.changePercent }
    }

    func fetchTopLosers() async throws -> [Stock] {
        let response: YahooQuoteBody =
            try await client.request(
                YahooMarketEndpoint.screener(screen: .losers, apiKey: secrets.rapidAPIKey)
            )

        return response.body
            .map(mapper.stock)
            .sorted { $0.changePercent < $1.changePercent }
    }

    func fetchMarketTrend() async throws -> [ChartPoint] {
        []
    }
}
