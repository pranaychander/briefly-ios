//
//  YahooQuote.swift
//  Briefly
//
//  Created by Pranay Chander on 05/02/26.
//

import Foundation

struct YahooQuoteBody: Decodable {
    let body: [YahooQuote]
}

struct YahooQuote: Decodable {
    let symbol: String
    let shortName: String?
    let regularMarketPrice: Double
    let regularMarketChangePercent: Double
}
