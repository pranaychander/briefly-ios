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
        // Combine selftext + top comments
        var combinedContent = dto.contentPreview ?? ""
        
        // Add top 1-3 comments if available
        if !(dto.comments?.isEmpty ?? false) {
            let commentText = dto.comments?.prefix(3).map { "u/\($0.author): \($0.body)" }.joined(separator: "\n\n")
            if !combinedContent.isEmpty {
                combinedContent += "\n\n" + (commentText ?? "")
            } else {
                combinedContent = commentText ?? ""
            }
        }
        return Article(
            id: dto.id,
            title: dto.title,
            url: dto.url,
            author: dto.author,
            publishedAt: Date(timeIntervalSince1970: dto.created_utc),
            score: dto.score,
            source: .reddit,
            topic: Topic(rawValue: dto.topic ?? "") ?? .business,
            thumbnailURL: dto.bestImageURL,
            contentPreview: combinedContent
        )
    }
}
