//
//  HomeViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published private(set) var articles: [Article] = []
    @Published private(set) var allArticles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var selectedType: HomeFeedType = .forYou

    private let aggregateArticlesUseCase: AggregateArticlesUseCase
    private let settingsStore: UserSettingsStore
    private var cancellables = Set<AnyCancellable>()

    init(
        settingsStore: UserSettingsStore,
        aggregateUseCase: AggregateArticlesUseCase
    ) {
        self.settingsStore = settingsStore
        self.aggregateArticlesUseCase = aggregateUseCase
        observeTopics()
    }
    
    private func observeTopics() {
        settingsStore.$state
            .map(\.selectedTopics)
            .removeDuplicates()
            .sink { [weak self] topics in
                Task { await self?.load() }
            }
            .store(in: &cancellables)
    }

    private var filteredTopics: Set<Topic> {
        switch selectedType {
        case .forYou:
            return settingsStore.state.selectedTopics
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
}
