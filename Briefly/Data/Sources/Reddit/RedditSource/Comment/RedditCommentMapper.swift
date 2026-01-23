//
//  RedditCommentMapper.swift
//  Briefly
//
//  Created by Pranay Chander on 23/01/26.
//

import Foundation

protocol RedditCommentMapper {
    func map(_ dto: RedditCommentDTO) -> Comment?
}

struct DefaultRedditCommentMapper: RedditCommentMapper {
    func map(_ dto: RedditCommentDTO) -> Comment? {
        guard
            let body = dto.body,
            let author = dto.author,
            let createdUTC = dto.created_utc
        else {
            return nil
        }

        return Comment(
            id: dto.id,
            author: author,
            body: body,
            score: dto.score ?? 0,
            createdAt: Date(timeIntervalSince1970: createdUTC)
        )
    }
}
