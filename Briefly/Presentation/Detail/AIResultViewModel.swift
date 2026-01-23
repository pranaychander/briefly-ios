//
//  AIResultViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import Foundation
import Combine

final class AIResultViewModel: ObservableObject {

    @Published var output: String = ""
    @Published var isLoading: Bool = false

    private let article: Article
    private let action: AIAction

    init(article: Article, action: AIAction) {
        self.article = article
        self.action = action
    }

    func generate() {
        isLoading = true

        // Simulated AI generation (replace with on-device / API call)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.output = "[AI Generated]\n\n" + self.action.systemPrompt + "\n\n" + self.article.title
            self.isLoading = false
        }
    }
}
