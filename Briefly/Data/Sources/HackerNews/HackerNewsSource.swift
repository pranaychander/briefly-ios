//
//  HackerNewsSource.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

final class HackerNewsSource: ArticleSource {

    let source: ContentSource = .hackerNews

    private let apiClient: APIClient
    private let mapper: HackerNewsMapper

    init(
        apiClient: APIClient,
        mapper: HackerNewsMapper = HackerNewsMapper()
    ) {
        self.apiClient = apiClient
        self.mapper = mapper
    }

    func fetchArticles(topic: Topic, limit: Int) async throws -> [Article] {
        guard topic == .technology else {
            return []
        }
        let ids: [Int] = try await apiClient.request(HackerNewsEndpoint.stories(.top))
        let selected = Array(ids.prefix(limit))
        return try await fetchStories(ids: selected)
    }
}

// MARK: - Private helpers

private extension HackerNewsSource {

    func fetchStories(ids: [Int]) async throws -> [Article] {
        try await withThrowingTaskGroup(of: Article?.self) { group in

            for id in ids {
                group.addTask {
                    let dto: HNItemDTO = try await self.apiClient.request(
                        HackerNewsEndpoint.item(id: id)
                    )
                    return self.mapper.map(dto)
                }
            }

            var articles: [Article] = []

            for try await article in group {
                if let article {
                    articles.append(article)
                }
            }

            return articles
        }
    }
}
