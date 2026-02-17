//
//  MarketOverview.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import Foundation

struct MarketOverview {
    let indices: [MarketIndex]
    let gainers: [Stock]
    let losers: [Stock]
    let chart: [ChartPoint]
}
