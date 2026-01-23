//
//  AIAction.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import Foundation

enum AIAction: CaseIterable, Identifiable {
    case summary
    case tweet
    case reddit
    case linkedin

    var id: String { displayName }

    var displayName: String {
        switch self {
        case .summary: return "TL;DR Summary"
        case .tweet: return "Generate Tweet"
        case .reddit: return "Reddit Post"
        case .linkedin: return "LinkedIn Post"
        }
    }

    var systemPrompt: String {
        switch self {
        case .summary:
            return "Summarize this article in bullet points."
        case .tweet:
            return "Write a concise, engaging tweet based on this article."
        case .reddit:
            return "Write a Reddit-style post discussing this article."
        case .linkedin:
            return "Write a professional LinkedIn post based on this article."
        }
    }
}
