//
//  ArticleDetailViewModelFactory.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import Foundation

protocol ArticleDetailViewModelFactory {
    func make(article: Article) -> ArticleDetailViewModel
}

final class DefaultArticleDetailViewModelFactory: ArticleDetailViewModelFactory {
    private let sourceResolver: ArticleSourceResolver
    private let generateAIPreviewUseCase: GenerateAIArticlePreviewUseCase
    private let aiContentFactory: AIResultViewModelFactory

    init(
        sourceResolver: ArticleSourceResolver,
        generateAIPreviewUseCase: GenerateAIArticlePreviewUseCase,
        aiContentFactory: AIResultViewModelFactory
        
    ) {
        self.sourceResolver = sourceResolver
        self.generateAIPreviewUseCase = generateAIPreviewUseCase
        self.aiContentFactory = aiContentFactory
    }

    func make(article: Article) -> ArticleDetailViewModel {
        let source = sourceResolver.resolve(for: article.source)

        return ArticleDetailViewModel(
            article: article,
            articleSource: source,
            generateAIPreviewUseCase: generateAIPreviewUseCase,
            aiContentFactory: aiContentFactory
        )
    }
}
