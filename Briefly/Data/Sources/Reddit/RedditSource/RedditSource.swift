//
//  RedditSource.swift
//  Briefly
//
//  Created by Pranay Chander on 31/12/25.
//

import Foundation

final class RedditSource: ArticleSource {

    let source: ContentSource = .reddit

    private let apiClient: APIClient
    private let mapper: RedditPostMapper
    private let strategy: RedditScoreStrategy

    init(
        apiClient: APIClient,
        mapper: RedditPostMapper = DefaultRedditPostMapper(),
        strategy: RedditScoreStrategy = RedditScoreStrategy()
    ) {
        self.apiClient = apiClient
        self.mapper = mapper
        self.strategy = strategy
    }

    func fetchArticles(topic: Topic, limit: Int) async throws -> [Article] {
        let subreddit = topic.toRedditSubreddit()
        let endpoint = RedditEndpoint.posts(
            .top(
                subreddit: subreddit,
                limit: limit,
                timeRange: .day
            )
        )

        let dto: RedditListingDTO = try await apiClient.request(endpoint)

        return dto.data.children.map { child in
            var article = mapper.map(child.data)
            article.score = strategy.score(article: article)
            return article
        }
    }
}
