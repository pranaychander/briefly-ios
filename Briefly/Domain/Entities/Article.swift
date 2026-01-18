//
//  Article.swift
//  Briefly
//
//  Created by Pranay Chander on 21/12/25.
//

import Foundation

struct Article: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let url: String?
    let author: String
    let publishedAt: Date
    var score: Int
    let source: ContentSource
    let topic: Topic
    let thumbnailURL: URL?
}

extension Article {

    /// Subtitle shown under title in feed cells
    var subtitleText: String {
        var parts: [String] = []

        if !author.isEmpty {
            parts.append("by \(author)")
        }

        parts.append(source.displayName)

        if score > 0 {
            parts.append("\(score) points")
        }

        return parts.joined(separator: " • ")
    }
}

