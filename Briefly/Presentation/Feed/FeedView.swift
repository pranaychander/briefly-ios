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
            List(viewModel.articles) { article in
                ArticleRowView(article: article)
            }
            .navigationTitle("Briefly")
            .task {
                await viewModel.load()
            }
        }
    }
}
