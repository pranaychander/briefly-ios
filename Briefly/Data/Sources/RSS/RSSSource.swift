//
//  RSSSource.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

final class RSSSource: ArticleSource {

    let source: ContentSource = .rss

    private let apiClient: APIClient
    private let parser: RSSParser
    private let mapper: RSSMapper

    init(
        apiClient: APIClient,
        parser: RSSParser = RSSParser(),
        mapper: RSSMapper = RSSMapper()
    ) {
        self.apiClient = apiClient
        self.parser = parser
        self.mapper = mapper
    }

    func fetchArticles(limit: Int) async throws -> [Article] {

        let data = try await apiClient.requestData(
            RSSEndpoint.feed(.technology)
        )

        let items = parser.parse(data: data)

        return items
            .prefix(limit)
            .map { mapper.map($0) }
    }
}

