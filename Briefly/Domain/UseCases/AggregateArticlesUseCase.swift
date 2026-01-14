//
//  AggregateArticlesUseCase.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

protocol AggregateArticlesUseCase {
    func execute(topics: Set<Topic>, limitPerTopic: Int) async throws -> [Article]
}

final class DefaultAggregateArticlesUseCase: AggregateArticlesUseCase {

    private let sources: [ArticleSource]

    init(sources: [ArticleSource]) {
        self.sources = sources
    }

    func execute(topics: Set<Topic>, limitPerTopic: Int) async throws -> [Article] {
        try await withThrowingTaskGroup(of: [Article].self) { group in
            for topic in topics {
                for source in sources {
                    group.addTask {
                        try await source.fetchArticles(topic: topic, limit: limitPerTopic)
                    }
                }
            }
            var combined: [Article] = []
            
            for try await articles in group {
                combined.append(contentsOf: articles)
            }

            return ArticleRanker.rank(combined)
        }
    }
}
