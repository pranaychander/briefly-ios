//
//  ArticleMetaView.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import SwiftUI

struct ArticleMetaView: View {

    let article: Article

    var body: some View {
        HStack(spacing: 6) {
            Text(article.author)
            Text("•")
            Text(article.publishedAt.relativeDescription)
            Text("•")
            Text(article.source.displayName)
            Spacer()
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
}
