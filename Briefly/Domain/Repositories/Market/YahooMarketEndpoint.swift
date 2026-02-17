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
    case history(symbol: String, interval: String, limit: Int, dividend: Bool?, apiKey: String)

    var baseURL: URL {
        URL(string: "https://yahoo-finance15.p.rapidapi.com")!
    }

    var path: String {
        switch self {
        case .quotes:
            return "/api/v1/markets/stock/quotes"
        case .screener:
            return "/api/v1/markets/screener"
        case .history:
            return "/api/v2/markets/stock/history"
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
        case .history(_, _, _, _, let apiKey):
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
        case .history(let symbol, let interval, let limit, let dividend, _):
            var items: [URLQueryItem] = [
                URLQueryItem(name: "symbol", value: symbol),
                URLQueryItem(name: "interval", value: interval),
                URLQueryItem(name: "limit", value: String(limit))
            ]
            if let dividend {
                items.append(
                    URLQueryItem(name: "dividend", value: dividend ? "true" : "false")
                )
            }
            return items
        }
    }
}
