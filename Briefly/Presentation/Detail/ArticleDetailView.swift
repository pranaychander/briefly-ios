//
//  ArticleDetailView.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import SwiftUI
import WebKit

struct ArticleDetailView: View {

    @StateObject var viewModel: ArticleDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // HERO IMAGE
                if let url = viewModel.article.thumbnailURL {
                    DetailHeroImage(url: url)
                }
                
                // TITLE
                Text(viewModel.article.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // META
                ArticleMetaView(article: viewModel.article)
                    .padding(.horizontal)
                
                // TOPIC + SCORE
                ArticleSignalsView(article: viewModel.article)
                    .padding(.horizontal)
                
                if let content = viewModel.article.contentPreview, !content.isEmpty {
                    Text(content)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineSpacing(6)
                        .padding(.horizontal)
                        .padding(.top, 8)
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button {
                    viewModel.showAIActionSheet = true
                } label: {
                    HStack {
                        Image(systemName: "sparkles")
                        Text("AI Actions")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                }

                Divider()

                if let url = viewModel.article.url, let articleURL = URL(string: url) {
                    NavigationLink {
                        WebView(url: articleURL)
                    } label: {
                        Text("Read Full Article")
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Article")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {

                Button {
                    shareArticle()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }

                Button {
                    toggleBookmark()
                } label: {
                    Image(systemName: "bookmark")
                }
            }
        }
        .sheet(isPresented: $viewModel.showAIActionSheet) {
            AIActionSheet { action in
                viewModel.selectedAIAction = action
            }
        }
        .navigationDestination(item: $viewModel.selectedAIAction) { action in
            AIResultView(article: viewModel.article, action: action)
        }
        .task {
            await viewModel.loadComments()
        }
    }
    
    func shareArticle() {
        guard let urlString = viewModel.article.url,
              let url = URL(string: urlString) else { return }

        let activity = UIActivityViewController(
            activityItems: [viewModel.article.title, url],
            applicationActivities: nil
        )

        UIApplication.shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?
            .rootViewController?
            .present(activity, animated: true)
    }
    
    func toggleBookmark() {
    }
}
