//
//  ArticleDetailViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import Foundation
import Combine

@MainActor
final class ArticleDetailViewModel: ObservableObject {
    @Published var article: Article
    private let source: ArticleSource
    @Published var isLoadingComments = false
    @Published var showAIActionSheet = false
    @Published var selectedAIAction: AIAction?
    
    init(article: Article, source: ArticleSource) {
        self.article = article
        self.source = source
    }
    
    func loadComments() async {
        guard !isLoadingComments else { return }
        isLoadingComments = true
        defer { isLoadingComments = false }
        
        do {
            let comments = try await source.fetchComments(for: article.id, limit: 3)
            guard !comments.isEmpty else { return }

            // Take first 3 comments and append to contentPreview
            let commentText = comments.prefix(3)
                .map { "\($0.author): \($0.body)" }
                .joined(separator: "\n\n")
            
            guard !commentText.isEmpty else { return }

            // Update article's contentPreview
            article = Article(
                id: article.id,
                title: article.title,
                url: article.url,
                author: article.author,
                publishedAt: article.publishedAt,
                score: article.score,
                source: article.source,
                topic: article.topic,
                thumbnailURL: article.thumbnailURL,
                contentPreview: [article.contentPreview, commentText]
                    .compactMap { $0 }
                    .joined(separator: "\n\n")
            )
            
        } catch {
            print("Failed to fetch comments: \(error)")
        }
    }

}
