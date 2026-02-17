//
//  MarketInterval.swift
//  Briefly
//
//  Created by Pranay Chander on 17/02/26.
//

import Foundation

enum MarketInterval: String, CaseIterable, Identifiable {
    case oneDay = "1d"
    case oneWeek = "1wk"
    case oneMonth = "1mo"

    var id: String { rawValue }

    // map UI selection to API interval + limit
    var apiInterval: String {
        switch self {
        case .oneDay: return "1m"
        case .oneWeek: return "15m"
        case .oneMonth: return "1d"
        }
    }

    var apiLimit: Int {
        switch self {
        case .oneDay: return 640
        case .oneWeek: return 640
        case .oneMonth: return 40
        }
    }

    var label: String { rawValue }
}
