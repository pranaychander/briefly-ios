//
//  AggregateArticlesUseCase.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation
import os

protocol AggregateArticlesUseCase {
    func execute(topics: Set<Topic>, limitPerTopic: Int) async throws -> [Article]
}

final class DefaultAggregateArticlesUseCase: AggregateArticlesUseCase {

    private let sources: [ArticleSource]

    init(sources: [ArticleSource]) {
        self.sources = sources
    }

    func execute(topics: Set<Topic>, limitPerTopic: Int) async -> [Article] {

        await withTaskGroup(of: [Article].self) { group in

            for topic in topics {
                for source in sources {
                    group.addTask {
                        do {
                            return try await source.fetchArticles(
                                topic: topic,
                                limit: limitPerTopic
                            )
                        } catch {
                            Logger.feed.error(
                                "Fetch failed | source=\(source.source.rawValue) topic=\(topic.rawValue) error=\(error.localizedDescription)"
                            )
                            return []
                        }
                    }
                }
            }

            var combined: [Article] = []

            for await articles in group {
                combined.append(contentsOf: articles)
            }

            return ArticleRanker.rank(combined)
        }
    }
}
