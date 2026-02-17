//
//  YahooHistory.swift
//  Briefly
//
//  Created by Pranay Chander on 17/02/26.
//

import Foundation

struct YahooHistoryResponse: Decodable {
    let items: [String: YahooHistoryItem]?
    let error: YahooHistoryError?
}

struct YahooHistoryWrapper: Decodable {
    let body: YahooHistoryResponse?
}

struct YahooHistoryArrayWrapper: Decodable {
    let body: [YahooHistoryArrayItem]?
}

struct YahooHistoryItem: Decodable {
    let dateUTC: Int
    let close: Double?

    enum CodingKeys: String, CodingKey {
        case dateUTC = "date_utc"
        case close
    }
}

struct YahooHistoryArrayItem: Decodable {
    let timestampUnix: Int
    let close: Double?

    enum CodingKeys: String, CodingKey {
        case timestampUnix = "timestamp_unix"
        case close
    }
}

struct YahooHistoryError: Decodable {
    let code: String?
    let description: String?
}

struct YahooHistoryMessageError: Decodable {
    let message: String?
    let error: String?
}
