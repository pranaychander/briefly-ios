//
//  HackerNewsDTO.swift
//  Briefly
//
//  Created by Pranay Chander on 31/12/25.
//

import Foundation

struct HNItemDTO: Decodable {
    let id: Int
    let type: String?
    let title: String?
    let url: String?
    let by: String?
    let time: TimeInterval?
    let score: Int?
    let topic: String?
    let kids: [Int]?
    let text: String?
}
