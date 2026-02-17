//
//  MoverType.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import Foundation

enum MoverType: String, CaseIterable, Identifiable {
    case gainers = "Top Gainers"
    case losers = "Top Losers"

    var id: Self { self }
}
