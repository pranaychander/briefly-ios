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
    private let generatePreviewUseCase: GenerateArticlePreviewUseCase

    init(
        sourceResolver: ArticleSourceResolver,
        generatePreviewUseCase: GenerateArticlePreviewUseCase
    ) {
        self.sourceResolver = sourceResolver
        self.generatePreviewUseCase = generatePreviewUseCase
    }

    func make(article: Article) -> ArticleDetailViewModel {
        let source = sourceResolver.resolve(for: article.source)

        return ArticleDetailViewModel(
            article: article,
            articleSource: source,
            generatePreviewUseCase: generatePreviewUseCase
        )
    }
}
