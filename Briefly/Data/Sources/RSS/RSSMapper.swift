//
//  RSSMapper.swift
//  Briefly
//
//  Created by Pranay Chander on 07/01/26.
//

import Foundation

struct RSSMapper {

    func map(_ dto: RSSItemDTO) -> Article {
        let contentPreview = dto.description?.strippedHTML
        return Article(
            id: dto.link, // Use link as unique ID
            title: dto.title,
            url: dto.link,
            author: dto.author ?? "Unknown",
            publishedAt: dto.publishedDate ?? Date(),
            score: 0, // RSS doesn’t have score, optional later
            source: .rss,
            topic: Topic(rawValue: dto.topic) ?? .business,
            thumbnailURL: dto.thumbnailURL,
            contentPreview: contentPreview
        )
    }
}

