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
    private let commentMapper: RedditCommentMapper
    
    init(
        apiClient: APIClient,
        mapper: RedditPostMapper = DefaultRedditPostMapper(),
        commentMapper: RedditCommentMapper = DefaultRedditCommentMapper(),
        strategy: RedditScoreStrategy = RedditScoreStrategy()
    ) {
        self.apiClient = apiClient
        self.mapper = mapper
        self.commentMapper = commentMapper
        self.strategy = strategy
    }
    
    func fetchArticles(topic: Topic, limit: Int) async throws -> [Article] {
        let subreddit = topic.toRedditSubreddit()
        let endpoint = RedditEndpoint.posts(.top(subreddit: subreddit, limit: limit, timeRange: .day))
        let dto: RedditListingDTO = try await apiClient.request(endpoint)
        
        return dto.data.children.map { child in
            var article = mapper.map(child.data)
            article.score = strategy.score(article: article)
            article.topic = topic
            return article
        }
    }
    
    func fetchComments(for articleId: String, limit: Int) async throws -> [Comment] {

        let listings: [RedditCommentsListingDTO] = try await apiClient.request(RedditEndpoint.comments(postId: articleId, limit: limit))

        guard listings.count > 1 else { return [] }

        return listings[1].data.children.compactMap { commentMapper.map($0.data) }
    }
}
