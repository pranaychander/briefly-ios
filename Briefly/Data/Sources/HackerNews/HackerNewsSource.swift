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
    private let commentMapper: HackerNewsCommentMapper
    init(
        apiClient: APIClient,
        mapper: HackerNewsMapper = DefaultHackerNewsMapper(),
        commentMapper: HackerNewsCommentMapper = DefaultHackerNewsCommentMapper()
    ) {
        self.apiClient = apiClient
        self.mapper = mapper
        self.commentMapper = commentMapper
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
                    let dto: HNItemDTO = try await self.apiClient.request(HackerNewsEndpoint.item(id: id))
                    var article = self.mapper.map(dto)
                    article?.topic = .technology
                    return article
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

extension HackerNewsSource {

    func fetchComments(for articleId: String, limit: Int) async throws -> [Comment] {

        guard let storyId = Int(articleId) else {
            return []
        }

        let story: HNItemDTO = try await apiClient.request(HackerNewsEndpoint.item(id: storyId))

        guard let kids = story.kids, !kids.isEmpty else {
            return []
        }

        let selected = Array(kids.prefix(limit))

        return try await withThrowingTaskGroup(of: Comment?.self) { group in

            for id in selected {
                group.addTask {
                    let dto: HNItemDTO = try await self.apiClient.request(HackerNewsEndpoint.item(id: id))
                    return self.commentMapper.map(dto)
                }
            }

            var comments: [Comment] = []

            for try await comment in group {
                if let comment {
                    comments.append(comment)
                }
            }
            return comments
        }
    }
}
