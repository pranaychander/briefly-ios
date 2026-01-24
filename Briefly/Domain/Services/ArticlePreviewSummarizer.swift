//
//  ArticlePreviewSummarizer.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import Foundation

enum ArticlePreviewSummarizer {

    static func summarize(article: Article, comments: [Comment]) -> String {

        var parts: [String] = []

        if let existing = article.contentPreview, !existing.isEmpty {
            parts.append(existing)
        }

        let topComments = comments.prefix(3)
            .map { "\($0.author): \($0.body)" }

        if !topComments.isEmpty {
            parts.append(topComments.joined(separator: "\n\n"))
        }

        return parts.joined(separator: "\n\n")
    }
}
