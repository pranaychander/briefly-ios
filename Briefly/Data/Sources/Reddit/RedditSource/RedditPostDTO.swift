//
//  RedditPostDTO.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

struct RedditListingDTO: Decodable {
    let data: RedditListingData
}

struct RedditListingData: Decodable {
    let children: [RedditChild]
}

struct RedditChild: Decodable {
    let data: RedditPostDTO
}

struct RedditPostDTO: Decodable {
    let id: String
    let title: String
    let url: String
    let author: String
    let created_utc: TimeInterval
    let score: Int
    let topic: String
}
