//
//  ArticleRepository.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

protocol ArticleRepository {
    func fetchTopArticles(limit: Int) async throws -> [Article]
}

