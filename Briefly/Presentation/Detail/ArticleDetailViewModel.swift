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

    private let generateAIPreviewUseCase: GenerateAIArticlePreviewUseCase
    private let aiContentFactory: AIResultViewModelFactory

    // MARK: - Init

    init(article: Article, articleSource: ArticleSource, generateAIPreviewUseCase: GenerateAIArticlePreviewUseCase, aiContentFactory: AIResultViewModelFactory) {
        self.article = article
        self.source = articleSource
        self.generateAIPreviewUseCase = generateAIPreviewUseCase
        self.aiContentFactory = aiContentFactory
    }

    // MARK: - Actions

    func loadPreview() async {
        guard !isLoadingComments else { return }
        isLoadingComments = true
        defer { isLoadingComments = false }

        do {
            let article = try await generateAIPreviewUseCase.execute(article: article)
            self.article = article

        } catch {
            print("Preview generation failed: \(error)")
        }
    }
    
    func selectAIAction(_ action: AIAction) {
        showAIActionSheet = false
        selectedAIAction = action
    }
    
    func makeAIResultViewModel() -> AIResultViewModel {
        return aiContentFactory.make(article: article, action: selectedAIAction ?? .summary)
    }
}

