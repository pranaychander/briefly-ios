//
//  AIActionPromptBuilder.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import Foundation

struct AIActionPromptBuilder: AIPromptBuilder {

    let article: Article
    let action: AIAction

    var instructions: String {
        action.instructions
    }

    var prompt: String {
        """
        Article Title:
        \(article.title)

        Article Content:
        \(article.contentPreview ?? "")
        """
    }
}
