//
//  GenerateAIContentUseCase.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import Foundation

protocol GenerateAIContentUseCase {
    func execute(article: Article,action: AIAction) async throws -> String
}

final class DefaultGenerateAIContentUseCase: GenerateAIContentUseCase {

    private let service: AIService

    init(service: AIService) {
        self.service = service
    }

    func execute(article: Article, action: AIAction) async throws -> String {
        let builder = AIActionPromptBuilder(
            article: article,
            action: action
        )
        return try await service.generate(using: builder)
    }
}
