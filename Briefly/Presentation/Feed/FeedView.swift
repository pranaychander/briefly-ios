//
//  FeedView.swift
//  Briefly
//
//  Created by Pranay Chander on 21/12/25.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel: FeedViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // MARK: - Topic Picker
                TopicPickerView(
                    topics: Topic.allCases,
                    selection: $viewModel.selectedTopics
                )
                .padding(.vertical, 8)
                
                // MARK: - Search Field
                searchBar
                
                // MARK: - Content
                ZStack {
                    content
                    if viewModel.isLoading {
                        loaderOverlay
                    }
                }
            }
            .navigationTitle("Briefly")
            .task {
                await viewModel.load()
            }
        }
    }
    
    // MARK: - Search Bar
    private var searchBar: some View {
        TextField("Search articles...", text: $searchText)
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
            .onChange(of: searchText) { newValue in
                // Filter articles in ViewModel
                viewModel.filterArticles(query: newValue)
            }
    }
    
    // MARK: - Content Selector
    @ViewBuilder
    private var content: some View {
        if let error = viewModel.errorMessage {
            errorView(error)
        } else if viewModel.articles.isEmpty && !viewModel.isLoading {
            emptyView
        } else {
            listView
        }
    }
}

// MARK: - Subviews
extension FeedView {
    
    private var listView: some View {
        List(viewModel.articles) { article in
            ArticleRowView(article: article)
                .listRowSeparator(.hidden)
                .padding(.vertical, 4)
        }
        .listStyle(.plain)
        .animation(.default, value: viewModel.articles)
        .refreshable {
            await viewModel.load()
        }
    }
    
    private var loaderOverlay: some View {
        ProgressView()
            .scaleEffect(1.2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
    }
    
    private var emptyView: some View {
        ContentUnavailableView(
            "No Articles",
            systemImage: "newspaper",
            description: Text("Pull to refresh or try again later.")
        )
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundStyle(.orange)
            
            Text(message)
                .multilineTextAlignment(.center)
            
            Button("Retry") {
                Task { await viewModel.load() }
            }
        }
        .padding()
    }
}

