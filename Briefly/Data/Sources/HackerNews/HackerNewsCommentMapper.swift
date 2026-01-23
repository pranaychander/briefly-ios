//
//  HackerNewsCommentMapper.swift
//  Briefly
//
//  Created by Pranay Chander on 23/01/26.
//

import Foundation

protocol HackerNewsCommentMapper {
    func map(_ dto: HNItemDTO) -> Comment?
}

struct DefaultHackerNewsCommentMapper: HackerNewsCommentMapper {
    func map(_ dto: HNItemDTO) -> Comment? {
        guard
            dto.type == "comment",
            let text = dto.text,
            let author = dto.by,
            let time = dto.time
        else {
            return nil
        }

        return Comment(
            id: String(dto.id),
            author: author,
            body: text.strippedHTML,
            score: dto.score ?? 0,
            createdAt: Date(timeIntervalSince1970: time)
        )
    }
}
