//
//  AIResultViewModelFactory.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import Foundation

protocol AIResultViewModelFactory {
    func make(article: Article, action: AIAction) -> AIResultViewModel
}

final class DefaultAIResultViewModelFactoryFactory: AIResultViewModelFactory {
    private let generateAIContentUseCase: GenerateAIContentUseCase

    init(generateAIContentUseCase: GenerateAIContentUseCase) {
        self.generateAIContentUseCase = generateAIContentUseCase
    }

    func make(article: Article, action: AIAction) -> AIResultViewModel {
        return AIResultViewModel(article: article, action: action, useCase: generateAIContentUseCase)
    }
}
