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

    @Published private(set) var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedTopics: Set<Topic> {
        didSet {
            saveTopicsUseCase.execute(selectedTopics)
            Task { await load() }

        }
    }

    private let getTopicsUseCase: GetSelectedTopicsUseCase
    private let saveTopicsUseCase: SaveSelectedTopicsUseCase
    private let aggregateArticlesUseCase: AggregateArticlesUseCase

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

    // Load articles for all selected topics
    func load() async {
        guard !selectedTopics.isEmpty else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            articles = try await aggregateArticlesUseCase.execute(topics: selectedTopics, limitPerTopic: 20)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

//    // Add or remove a topic
//    func toggleTopic(_ topic: Topic) {
//        if selectedTopics.contains(topic) {
//            selectedTopics.remove(topic)
//        } else {
//            selectedTopics.insert(topic)
//        }
//
//        // Persist selection immediately
//            }
//
//    // Helper for UI to check if topic is selected
//    func isSelected(_ topic: Topic) -> Bool {
//        selectedTopics.contains(topic)
//    }
}


