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
        VStack(alignment: .leading, spacing: 6) {

            HStack {
                Text(article.source.rawValue.uppercased())
                    .font(.caption2)
                    .padding(4)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(4)

                Spacer()

                Text("▲ \(article.score)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Text(article.title)
                .font(.headline)
                .lineLimit(3)

            HStack {
                Text(article.author)
                Text("•")
                Text(article.publishedAt, style: .relative)
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}
