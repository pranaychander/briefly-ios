//
//  ChartPoint.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import Foundation

struct ChartPoint: Identifiable {
    let id = UUID()
    let time: Date
    let value: Double
}
