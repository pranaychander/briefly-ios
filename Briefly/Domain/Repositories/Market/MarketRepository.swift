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
    func fetchMarketTrend(
        symbol: String,
        interval: MarketInterval,
        limit: Int?,
        dividend: Bool?
    ) async throws -> [ChartPoint]
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

    func fetchMarketTrend(
        symbol: String,
        interval: MarketInterval,
        limit: Int?,
        dividend: Bool?
    ) async throws -> [ChartPoint] {
        let data = try await client.requestData(
            YahooMarketEndpoint.history(
                symbol: symbol,
                interval: interval.apiInterval,
                limit: limit ?? interval.apiLimit,
                dividend: dividend,
                apiKey: secrets.rapidAPIKey
            )
        )

        let decoder = JSONDecoder()

        let response: YahooHistoryResponse? = try? decoder.decode(YahooHistoryResponse.self, from: data)
        let wrapped: YahooHistoryWrapper? = try? decoder.decode(YahooHistoryWrapper.self, from: data)
        let arrayWrapped: YahooHistoryArrayWrapper? = try? decoder.decode(YahooHistoryArrayWrapper.self, from: data)
        let messageError: YahooHistoryMessageError? = try? decoder.decode(YahooHistoryMessageError.self, from: data)

        let resolved = response ?? wrapped?.body

        if let error = resolved?.error {
            let description = error.description ?? "Unknown error"
            throw NSError(domain: "MarketTrend", code: 1, userInfo: [
                NSLocalizedDescriptionKey: description
            ])
        }

        if let message = messageError?.message ?? messageError?.error {
            throw NSError(domain: "MarketTrend", code: 1, userInfo: [
                NSLocalizedDescriptionKey: message
            ])
        }

        if let items = resolved?.items {
            return items.values
                .compactMap { item in
                    guard let close = item.close else { return nil }
                    return ChartPoint(
                        time: Date(timeIntervalSince1970: TimeInterval(item.dateUTC)),
                        value: close
                    )
                }
                .sorted { $0.time < $1.time }
        }

        if let arrayItems = arrayWrapped?.body {
            return arrayItems
                .compactMap { item in
                    guard let close = item.close else { return nil }
                    return ChartPoint(
                        time: Date(timeIntervalSince1970: TimeInterval(item.timestampUnix)),
                        value: close
                    )
                }
                .sorted { $0.time < $1.time }
        }

        let fallback = data.prettyPrintedJSONString() ?? "Unknown response"
        throw NSError(domain: "MarketTrend", code: 1, userInfo: [
            NSLocalizedDescriptionKey: "Unexpected response: \(fallback)"
        ])
    }
}
