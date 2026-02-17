//
//  ArticleSource.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

protocol ArticleSource {
    var source: ContentSource { get }
    func fetchArticles(topic: Topic, limit: Int) async throws -> [Article]
    func fetchComments(for articleId: String, limit: Int) async throws -> [Comment]
}

extension ArticleSource {
    func fetchComments(for articleId: String, limit: Int) async throws -> [Comment] {
        return []
    }
}
