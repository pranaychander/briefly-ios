//
//  Stock.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import Foundation

struct Stock: Identifiable, Equatable {
    let id = UUID()
    let symbol: String
    let price: Double
    let changePercent: Double
}
