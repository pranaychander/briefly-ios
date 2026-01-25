//
//  HomeViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import Foundation
import Combine

@MainActor
@Observable
final class HomeViewModel {

    private(set) var articles: [Article] = []
    private(set) var allArticles: [Article] = []
    var isLoading = false
    var errorMessage: String?

    var selectedType: HomeFeedType = .forYou

    private let aggregateArticlesUseCase: AggregateArticlesUseCase
    private let topicProvider: TopicPreferencesProvider
    private let detailFactory: ArticleDetailViewModelFactory
    
    private var cancellables = Set<AnyCancellable>()

    init(
        topicProvider: TopicPreferencesProvider,
        aggregateUseCase: AggregateArticlesUseCase,
        detailsFactory: ArticleDetailViewModelFactory
    ) {
        self.topicProvider = topicProvider
        self.aggregateArticlesUseCase = aggregateUseCase
        self.detailFactory = detailsFactory
    }
    

    private var filteredTopics: Set<Topic> {
        switch selectedType {
        case .forYou:
            return topicProvider.selectedTopics
        case .topic(let topic):
            return [topic]
        }
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let fetched = try await aggregateArticlesUseCase.execute(
                topics: filteredTopics,
                limitPerTopic: 20
            )
            allArticles = fetched
            articles = fetched
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func filterArticles(query: String) {
        guard !query.isEmpty else {
            articles = allArticles
            return
        }

        let q = query.lowercased()
        articles = allArticles.filter {
            $0.title.lowercased().contains(q)
            || $0.author.lowercased().contains(q)
        }
    }
    
    func makeDetailViewModel(for article: Article) -> ArticleDetailViewModel {
        detailFactory.make(article: article)
    }
}
