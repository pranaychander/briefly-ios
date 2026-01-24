//
//  ArticleSummarizer.swift
//  Briefly
//
//  Created by Pranay Chander on 23/01/26.
//

import Foundation

protocol ArticleSummarizer {
    func summarize( article: Article, comments: [Comment]) async throws -> String
}

struct DefaultArticleSummarizer: ArticleSummarizer {
    func summarize( article: Article, comments: [Comment]) async throws -> String {
        var sections: [String] = []

        if let preview = article.contentPreview {
            sections.append(preview)
        }

        let topComments = comments.sorted { $0.score > $1.score }.prefix(3)
        if !topComments.isEmpty {
            let text = topComments
                .map { "• \($0.author): \($0.body)" }
                .joined(separator: "\n")
            sections.append("Top comments:\n\(text)")
        }
        return sections.joined(separator: "\n\n")
    }
}
