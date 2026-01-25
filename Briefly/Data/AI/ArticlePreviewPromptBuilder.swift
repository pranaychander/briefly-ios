//
//  ArticlePreviewPromptBuilder.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import Foundation

struct ArticlePreviewPromptBuilder: AIPromptBuilder {

    let article: Article
    let comments: [Comment]

    var instructions: String {
        """
        You are BRU, a quiet news summarization engine.

        Write a single, concise paragraph summarizing the article and its discussion.

        Rules:
        - Output plain text only
        - One paragraph only
        - Do not add headings, bullets, or lists
        - Do not add introductions or conclusions
        - Do not mention that this is a summary
        - Do not explain, analyze, or editorialize
        - Do not stretch or pad the text if information is limited
        - If content is insufficient, write a very brief paragraph instead

        Tone:
        Neutral, factual, human, and journalistic.
        """
    }

    
    var prompt: String {
        let topComments = comments
            .sorted { $0.score > $1.score }
            .prefix(5)
            .map { "\($0.author): \($0.body)" }
            .joined(separator: "\n")

        return """
        Article Title:
        \(article.title)

        Content:
        \(article.contentPreview ?? "No body")

        Comments:
        \(topComments)
        """
    }
}
