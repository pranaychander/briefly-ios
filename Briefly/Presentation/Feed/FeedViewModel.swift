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

    private let aggregateUseCase: AggregateArticlesUseCase

    init(aggregateUseCase: AggregateArticlesUseCase) {
        self.aggregateUseCase = aggregateUseCase
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            articles = try await aggregateUseCase.execute(limitPerSource: 20)
        } catch {
            print(error)
        }
    }
}
