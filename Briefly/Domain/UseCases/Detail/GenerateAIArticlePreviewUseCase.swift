//
//  GenerateAIArticlePreviewUseCase.swift
//  Briefly
//
//  Created by Pranay Chander on 23/01/26.
//

import Foundation

protocol GenerateAIArticlePreviewUseCase {
    func execute(article: Article) async throws -> Article
}

final class DefaultAIGenerateArticlePreviewUseCase: GenerateAIArticlePreviewUseCase {

    private let sourceResolver: ArticleSourceResolver
    private let service: AIService

    init(sourceResolver: ArticleSourceResolver, service: AIService) {
        self.sourceResolver = sourceResolver
        self.service = service
    }

    func execute(article: Article) async throws -> Article {
        let source = sourceResolver.resolve(for: article.source)

        let comments = try await source.fetchComments(
            for: article.id,
            limit: 3
        )
            
        let builder = ArticlePreviewPromptBuilder(
            article: article,
            comments: comments
        )

        let preview = try await service.generate(using: builder)
        var article = article
        article.contentPreview = preview
        return article
    }
}
