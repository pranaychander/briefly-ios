//
//  RedditCommentDTO.swift
//  Briefly
//
//  Created by Pranay Chander on 23/01/26.
//

import Foundation

struct RedditCommentsListingDTO: Decodable {
    let data: RedditCommentsListingData
}

struct RedditCommentsListingData: Decodable {
    let children: [RedditCommentChild]
}

struct RedditCommentChild: Decodable {
    let data: RedditCommentDTO
}

struct RedditCommentDTO: Decodable, Identifiable {
    let id: String
    let author: String?
    let body: String?
    let score: Int?
    let created_utc: TimeInterval?
}
