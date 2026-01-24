//
//  ArticleSourceResolver.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import Foundation

protocol ArticleSourceResolver {
    func resolve(for source: ContentSource) -> ArticleSource
}

final class DefaultArticleSourceResolver: ArticleSourceResolver {

    private let reddit: ArticleSource
    private let hn: ArticleSource
    private let rss: ArticleSource

    init(
        reddit: ArticleSource,
        hn: ArticleSource,
        rss: ArticleSource
    ) {
        self.reddit = reddit
        self.hn = hn
        self.rss = rss
    }

    func resolve(for source: ContentSource) -> ArticleSource {
        switch source {
        case .reddit: return reddit
        case .hackerNews: return hn
        case .rss: return rss
        }
    }
}
