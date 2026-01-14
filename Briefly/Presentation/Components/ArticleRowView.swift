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
        VStack(alignment: .leading, spacing: 8) {

            // Source + time
            HStack(spacing: 8) {
                sourceBadge
                Spacer()
                Text(article.publishedAt.relativeDescription)
                    .font(.caption)
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

            }
        }
        .padding(.vertical, 8)
    }
}

private extension ArticleRowView {

    var sourceBadge: some View {
        Text(article.source.displayName)
            .font(.caption2)
            .fontWeight(.semibold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(article.source.color.opacity(0.15))
            .foregroundColor(article.source.color)
            .clipShape(Capsule())
    }
}
