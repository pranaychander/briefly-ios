//
//  DependencyContainer.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

final class DependencyContainer {

    // MARK: - Networking

    let apiClient = DefaultAPIClient()

    lazy var hnSource = HackerNewsSource(apiClient: apiClient)
    lazy var redditSource = RedditSource(apiClient: apiClient)
    lazy var rssSource = RSSSource(apiClient: apiClient)

    // MARK: - User Settings (Preferences)

    private lazy var userSettingsRepository: UserSettingsRepository = {
        UserSettingsLocalRepository()
    }()

    lazy var userSettingsStore: UserSettingsStore = {
        let initialState = userSettingsRepository.load()
        return UserSettingsStore(
            initialState: initialState,
            repository: userSettingsRepository
        )
    }()

    // MARK: - Use Cases

    lazy var aggregateArticlesUseCase: AggregateArticlesUseCase = {
        DefaultAggregateArticlesUseCase(
            sources: [hnSource, redditSource, rssSource]
        )
    }()
    
    // MARK: - ViewModels

        // lazy property for HomeViewModel
        lazy var homeViewModel: HomeViewModel = {
            HomeViewModel(
                settingsStore: userSettingsStore,
                aggregateUseCase: aggregateArticlesUseCase
            )
        }()
}
