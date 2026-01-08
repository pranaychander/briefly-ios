//
//  DependencyContainer.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation


final class DependencyContainer {

        let apiClient = DefaultAPIClient()

        // 2. Sources
        lazy var hnSource = HackerNewsSource(apiClient: apiClient)
        lazy var redditSource = RedditSource(apiClient: apiClient)
        lazy var rssSource = RSSSource(apiClient: apiClient)

    lazy var aggregateArticlesUseCase =
        DefaultAggregateArticlesUseCase(
            sources: [hnSource, redditSource, rssSource]
        )
}
