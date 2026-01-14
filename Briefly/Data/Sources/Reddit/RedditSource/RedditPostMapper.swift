//
//  RedditPostMapper.swift
//  Briefly
//
//  Created by Pranay Chander on 31/12/25.
//

import Foundation

protocol RedditPostMapper {
    func map(_ dto: RedditPostDTO) -> Article
}

struct DefaultRedditPostMapper: RedditPostMapper {

    func map(_ dto: RedditPostDTO) -> Article {
        Article(
            id: dto.id,
            title: dto.title,
            url: dto.url,
            author: dto.author,
            publishedAt: Date(timeIntervalSince1970: dto.created_utc),
            score: dto.score,
            source: .reddit,
            thumbnailURL: nil
        )
    }
}

