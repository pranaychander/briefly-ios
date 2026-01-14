//
//  FeedViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation
import Combine

@MainActor
final class FeedViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published private(set) var articles: [Article] = []
    @Published private(set) var allArticles: [Article] = [] // full list for filtering
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedTopics: Set<Topic> {
        didSet {
            saveTopicsUseCase.execute(selectedTopics)
            Task { await load() }
        }
    }

    // MARK: - Use Cases
    private let getTopicsUseCase: GetSelectedTopicsUseCase
    private let saveTopicsUseCase: SaveSelectedTopicsUseCase
    private let aggregateArticlesUseCase: AggregateArticlesUseCase

    // MARK: - Init
    init(
        getTopics: GetSelectedTopicsUseCase,
        saveTopics: SaveSelectedTopicsUseCase,
        aggregateUseCase: AggregateArticlesUseCase
    ) {
        self.getTopicsUseCase = getTopics
        self.saveTopicsUseCase = saveTopics
        self.aggregateArticlesUseCase = aggregateUseCase
        self.selectedTopics = getTopics.execute()
    }

    // MARK: - Load Articles
    func load() async {
        guard !selectedTopics.isEmpty else { return }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let fetched = try await aggregateArticlesUseCase.execute(
                topics: selectedTopics,
                limitPerTopic: 20
            )
            self.allArticles = fetched
            self.articles = fetched
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    // MARK: - Search / Filter
    func filterArticles(query: String) {
        if query.isEmpty {
            articles = allArticles
        } else {
            let lowercasedQuery = query.lowercased()
            articles = allArticles.filter { article in
                article.title.lowercased().contains(lowercasedQuery)
                    || (article.author.lowercased().contains(lowercasedQuery))
            }
        }
    }
}

