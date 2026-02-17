//
//  ChartPoint.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import Foundation

struct ChartPoint: Identifiable {
    let id = UUID()
    let time: Int
    let value: Double
}

let sampleChartData: [ChartPoint] = [
    .init(time: 1, value: 100),
    .init(time: 2, value: 102),
    .init(time: 3, value: 98),
    .init(time: 4, value: 105),
    .init(time: 5, value: 110)
]
