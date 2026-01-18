//
//  ArticleCardView.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import SwiftUI

struct ArticleCardView: View {
    
    let article: Article

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            AsyncImage(url: article.thumbnailURL) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 6) {

                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)

                Text("\(article.author) · \(article.publishedAt.relativeDescription)")
                    .font(.caption)
                    .foregroundColor(.secondary)

                HStack {
                    Text(article.topic.displayName)
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Capsule())

                    Spacer()

                    Image(systemName: "bookmark")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

