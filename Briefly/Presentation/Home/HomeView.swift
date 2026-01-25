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

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // TOP BAR
                TopBarView()
                    .padding(.bottom, 10)
                // HERO
                if let hero = viewModel.articles.first {
                    HeroArticleView(article: hero)
                }

                // TOPICS
                HomeFeedPickerView(
                    selection: $viewModel.selectedType
                )
                .padding(.vertical, 12)

                // ARTICLES
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
        .onChange(of: userSettings.state, { oldValue, newValue in
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
