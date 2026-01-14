//
//  ArticleRowView.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import SwiftUI

struct ArticleRowView: View {

    let article: Article

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            // Optional thumbnail
            if let imageURL = article.thumbnailURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 80, height: 80)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipped()
                            .cornerRadius(8)
                    case .failure:
                        Color.gray.opacity(0.2)
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            VStack(alignment: .leading, spacing: 6) {

                // Source + time + author
                HStack(spacing: 6) {
                    sourceBadge

                    if !article.author.isEmpty {
                        Text("by \(article.author)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Text(article.publishedAt.relativeDescription)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                // Title
                Text(article.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(3)

                // Optional subtitle / description
                if !article.subtitleText.isEmpty {
                    Text(article.subtitleText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

private extension ArticleRowView {

    var sourceBadge: some View {
        Text(article.source.displayName.uppercased())
            .font(.caption2)
            .fontWeight(.semibold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(article.source.color.opacity(0.2))
            .foregroundColor(article.source.color)
            .clipShape(Capsule())
    }
}
