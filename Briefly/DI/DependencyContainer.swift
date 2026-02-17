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
    
    // MARK: - Services
    
    lazy var aiService: AIService = {
        return BRUAIService()
    }()
    
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
    
    lazy var marketRepository: MarketRepository = {
        DefaultMarketRepository(client: apiClient, secrets: secrets)
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
            generateAIPreviewUseCase: generateAIPreviewUseCase,
            aiContentFactory: aiResultsFactory
        )
    }()
    
    lazy var aiResultsFactory: AIResultViewModelFactory = {
        DefaultAIResultViewModelFactoryFactory(generateAIContentUseCase: generateAIContentUseCase)
    }()
    
    // MARK: - Providers
    lazy var topicProvider: TopicPreferencesProvider = {
        userSettingsStore
    }()
    
    // MARK: - Secrets
    lazy var secrets: APISecrets = {
        APISecrets(rapidAPIKey: Secrets.rapidAPIKey)
    }()
    
    // MARK: - Use Cases
    
    lazy var aggregateArticlesUseCase: AggregateArticlesUseCase = {
        DefaultAggregateArticlesUseCase(
            sources: [hnSource, redditSource, rssSource]
        )
    }()
    
    lazy var generateAIPreviewUseCase: GenerateAIArticlePreviewUseCase = {
        DefaultAIGenerateArticlePreviewUseCase(sourceResolver: articleSourceResolver, service: aiService)
    }()
    
    lazy var generateAIContentUseCase: GenerateAIContentUseCase = {
        DefaultGenerateAIContentUseCase(service: aiService)
    }()
    
    lazy var loadMarketOverviewUseCase: LoadMarketOverviewUseCase = {
        DefaultLoadMarketOverviewUseCase(repository: marketRepository)
    }()

    lazy var loadMarketTrendUseCase: LoadMarketTrendUseCase = {
        DefaultLoadMarketTrendUseCase(repository: marketRepository)
    }()
    
    // MARK: - ViewModels
    
    // lazy property for HomeViewModel
    lazy var homeViewModel: HomeViewModel = {
        HomeViewModel(
            topicProvider: topicProvider,
            aggregateUseCase: aggregateArticlesUseCase,
            detailsFactory: articleDetailFactory
        )
    }()
    
    // lazy property for ProfileViewModel
    lazy var profileViewModel: ProfileViewModel = {
        ProfileViewModel()
    }()
    
    // lazy property for MarketViewModel
    lazy var marketViewModel: MarketViewModel = {
        MarketViewModel(loadMarketOverview: DefaultLoadMarketOverviewUseCase(repository: marketRepository), loadMarketTrend: loadMarketTrendUseCase)
    }()
}
