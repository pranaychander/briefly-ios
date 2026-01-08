//
//  ArticleDeduplicator.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

enum ArticleDeduplicator {

    static func deduplicate(_ articles: [Article]) -> [Article] {
        var seen = Set<String>()
        return articles.filter {
            if seen.contains($0.title) { return false }
            seen.insert($0.title)
            return true
        }
    }
}
