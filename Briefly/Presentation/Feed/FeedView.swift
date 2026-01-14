//
//  FeedView.swift
//  Briefly
//
//  Created by Pranay Chander on 21/12/25.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel: FeedViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TopicPickerView(
                    topics: Topic.allCases,
                    selection: $viewModel.selectedTopics
                )
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
extension FeedView {
    private var listView: some View {
        List(viewModel.articles) { article in
            ArticleRowView(article: article)
                .listRowSeparator(.hidden)
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

