//
//  ArticleDetailViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import Foundation
import Combine

@MainActor
@Observable
final class ArticleDetailViewModel {

    // MARK: - State

    private(set) var article: Article
    var source: ArticleSource
    var isLoadingComments = false
    var showAIActionSheet = false
    var selectedAIAction: AIAction?

    // MARK: - Dependencies

    private let generatePreviewUseCase: GenerateArticlePreviewUseCase

    // MARK: - Init

    init(article: Article, articleSource: ArticleSource, generatePreviewUseCase: GenerateArticlePreviewUseCase) {
        self.article = article
        self.source = articleSource
        self.generatePreviewUseCase = generatePreviewUseCase
    }

    // MARK: - Actions

    func loadPreview() async {
        guard !isLoadingComments else { return }
        isLoadingComments = true
        defer { isLoadingComments = false }

        do {
            let article = try await generatePreviewUseCase.execute(
                article: article
            )
            self.article = article

        } catch {
            print("Preview generation failed: \(error)")
        }
    }
}

