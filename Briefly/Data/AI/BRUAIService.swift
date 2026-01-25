//
//  BRUAIService.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import Foundation
import FoundationModels

final class BRUAIService: AIService {
    func generate(using builder: AIPromptBuilder) async throws -> String {
        let session = LanguageModelSession(instructions: builder.instructions)
        let response = try await session.respond(to: builder.prompt)
        return response.content
    }
}
