//
//  AIArticleSummarizer.swift
//  Briefly
//
//  Created by Pranay Chander on 23/01/26.
//

import Foundation
import FoundationModels

struct AIArticleSummarizer: ArticleSummarizer {
    func summarize(article: Article, comments: [Comment]) async throws -> String {
        // 1. Define the 'Behavior' in the instructions
        let instructions = """
            Summarize the provided article content and top comments in a concise, readable way.
            Produce exactly:
            - A short paragraph summary
            - 3 key takeaways
            """
        
        // 2. Initialize the session with these persistent instructions
        let session = LanguageModelSession(instructions: instructions)
        
        // 3. Prepare the data-specific prompt
        let topComments = comments
            .sorted { $0.score > $1.score }
            .prefix(5)
            .map { "\($0.author): \($0.body)" }
            .joined(separator: "\n")
            
        let prompt = """
            Article Title: \(article.title)
            Content: \(article.contentPreview ?? "No body")
            Comments: \(topComments)
            """
        
        // 4. Get the response content directly
        let response = try await session.respond(to: prompt)
        return response.content
    }
}


