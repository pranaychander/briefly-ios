//
//  ArticleRanker.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

enum ArticleRanker {

    static func rank(_ articles: [Article]) -> [Article] {
        let unique = ArticleDeduplicator.deduplicate(articles)
        return unique.sorted {
            $0.score > $1.score
        }
    }
}
