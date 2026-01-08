//
//  ArticleSource.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

protocol ArticleSource {
    var source: ContentSource { get }
    func fetchArticles(limit: Int) async throws -> [Article]
}
