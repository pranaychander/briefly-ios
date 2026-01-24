//
//  GenerateArticlePreviewUseCase.swift
//  Briefly
//
//  Created by Pranay Chander on 23/01/26.
//

import Foundation

protocol GenerateArticlePreviewUseCase {
    func execute(article: Article) async throws -> Article
}

final class DefaultGenerateArticlePreviewUseCase: GenerateArticlePreviewUseCase {

    private let sourceResolver: ArticleSourceResolver
    private let summarizer: ArticleSummarizer

    init(
        sourceResolver: ArticleSourceResolver,
        summarizer: ArticleSummarizer
    ) {
        self.sourceResolver = sourceResolver
        self.summarizer = summarizer
    }

    func execute(article: Article) async throws -> Article {
        let source = sourceResolver.resolve(for: article.source)

        let comments = try await source.fetchComments(
            for: article.id,
            limit: 3
        )

        let preview = try await summarizer.summarize(
            article: article,
            comments: comments
        )

        return article.withUpdatedPreview(preview)
    }
}

