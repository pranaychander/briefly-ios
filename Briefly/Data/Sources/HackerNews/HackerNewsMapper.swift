//
//  HackerNewsMapper.swift
//  Briefly
//
//  Created by Pranay Chander on 31/12/25.
//

import Foundation

struct HackerNewsMapper {

    func map(_ dto: HNItemDTO) -> Article? {
        guard dto.type == "story",
              let title = dto.title,
              let author = dto.by,
              let time = dto.time,
              let score = dto.score else {
            return nil
        }

        return Article(
            id: String(dto.id),
            title: title,
            url: dto.url,
            author: author,
            publishedAt: Date(timeIntervalSince1970: time),
            score: score,
            source: .hackerNews,
            topic: Topic(rawValue: dto.topic) ?? .business,
            thumbnailURL: nil
        )
    }
}
