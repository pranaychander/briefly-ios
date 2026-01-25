//
//  AIResultViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import Foundation

@Observable
final class AIResultViewModel {

    var output = ""
    var isLoading = false

    private let useCase: GenerateAIContentUseCase
    private let article: Article
    let action: AIAction

    init(article: Article, action: AIAction, useCase: GenerateAIContentUseCase) {
        self.article = article
        self.action = action
        self.useCase = useCase
    }

    @MainActor
    func generate() async {
        isLoading = true
        output = (try? await useCase.execute(
            article: article,
            action: action
        )) ?? ""
        isLoading = false
    }
}

