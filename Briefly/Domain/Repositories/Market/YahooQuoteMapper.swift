//
//  YahooQuoteMapper.swift
//  Briefly
//
//  Created by Pranay Chander on 05/02/26.
//

import Foundation

protocol YahooQuoteMapper {
    func stock(from quote: YahooQuote) -> Stock
    func index(from quote: YahooQuote, name: String) -> MarketIndex
}

struct DefaultYahooQuoteMapper: YahooQuoteMapper {

    func stock(from quote: YahooQuote) -> Stock {
        Stock(
            symbol: quote.symbol,
            price: quote.regularMarketPrice,
            changePercent: quote.regularMarketChangePercent
        )
    }

    func index(from quote: YahooQuote, name: String) -> MarketIndex {
        MarketIndex(
            id: quote.symbol,
            name: name,
            value: quote.regularMarketPrice,
            changePercent: quote.regularMarketChangePercent
        )
    }
}
