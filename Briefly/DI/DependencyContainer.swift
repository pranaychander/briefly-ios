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
    
    // MARK: - Resolvers
    lazy var articleSourceResolver: ArticleSourceResolver = {
        DefaultArticleSourceResolver(
            reddit: redditSource,
            hn: hnSource,
            rss: rssSource
        )
    }()
    
    // MARK: - Factories
    lazy var articleDetailFactory: ArticleDetailViewModelFactory = {
        DefaultArticleDetailViewModelFactory(
            sourceResolver: articleSourceResolver,
            generatePreviewUseCase: generatePreviewUseCase
        )
    }()
    
    // MARK: - Use Cases
    
    lazy var aggregateArticlesUseCase: AggregateArticlesUseCase = {
        DefaultAggregateArticlesUseCase(
            sources: [hnSource, redditSource, rssSource]
        )
    }()
    
    lazy var generatePreviewUseCase: GenerateArticlePreviewUseCase = {
        DefaultGenerateArticlePreviewUseCase(sourceResolver: articleSourceResolver, summarizer: AIArticleSummarizer())
    }()
    
    // MARK: - ViewModels
    
    // lazy property for HomeViewModel
    lazy var homeViewModel: HomeViewModel = {
        HomeViewModel(
            settingsStore: userSettingsStore,
            aggregateUseCase: aggregateArticlesUseCase,
            detailsFactory: articleDetailFactory
        )
    }()
    
    // lazy property for ProfileViewModel
    lazy var profileViewModel: ProfileViewModel = {
        ProfileViewModel(userSettingsStore: userSettingsStore)
    }()
}
