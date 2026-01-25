//
//  HomeView.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel: HomeViewModel
    @State private var hasLoadedData = false
    @Environment(UserSettingsStore.self) private var userSettings
    @Environment(AppNavigationState.self) private var nav
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let hero = viewModel.articles.first {
                    HeroArticleView(article: hero)
                }
                
                HomeFeedPickerView(
                    selection: $viewModel.selectedType
                )
                .padding(.vertical, 12)
                
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.articles.dropFirst()) { article in
                        NavigationLink(value: article) {
                            ArticleCardView(article: article)
                                .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .navigationTitle("Briefly")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    nav.selectedTab = .profile
                } label: {
                    Image(systemName: BrieflyTab.profile.icon)
                }
            }
        }
        .navigationDestination(for: Article.self) { article in
            ArticleDetailView(viewModel: viewModel.makeDetailViewModel(for: article))
        }
        .task {
            guard !hasLoadedData else { return }
            await viewModel.load()
            hasLoadedData = true
        }
        .onChange(of: viewModel.selectedType) {
            Task { await viewModel.load() }
        }
        .onChange(of: userSettings.state, { _, _ in
            Task { await viewModel.load() }
        })
        .overlay {
            if viewModel.isLoading {
                loaderOverlay
            }
        }
    }
    
    private var loaderOverlay: some View {
        ProgressView()
            .scaleEffect(1.3)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
    }
}
