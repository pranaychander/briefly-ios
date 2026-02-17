//
//  YahooMarketEndpoint.swift
//  Briefly
//
//  Created by Pranay Chander on 05/02/26.
//

import Foundation

enum YahooScreener: String {
    case gainers = "day_gainers"
    case losers = "day_losers"
}
enum YahooMarketEndpoint: APIEndpoint {

    case quotes(symbols: [String], apiKey: String)
    case screener(screen: YahooScreener, apiKey: String)

    var baseURL: URL {
        URL(string: "https://yahoo-finance15.p.rapidapi.com")!
    }

    var path: String {
        switch self {
        case .quotes:
            return "/api/v1/markets/stock/quotes"
        case .screener:
            return "/api/v1/markets/screener"
        }
        
    }

    var method: HTTPMethod { .get }

    var headers: [String: String] {
        switch self {
        case .quotes(_, let apiKey):
            return [
                "X-RapidAPI-Key": apiKey,
                "X-RapidAPI-Host": "yahoo-finance15.p.rapidapi.com"
            ]
        case .screener(_, let apiKey):
            return [
                "X-RapidAPI-Key": apiKey,
                "X-RapidAPI-Host": "yahoo-finance15.p.rapidapi.com"
            ]
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .quotes(let symbols, _):
            return [
                URLQueryItem(
                    name: "ticker",
                    value: symbols.joined(separator: ",")
                )
            ]
        case .screener(screen: let screen,_):
            return [
                URLQueryItem(
                    name: "list",
                    value: screen.rawValue
                )
            ]
        }
    }
}
