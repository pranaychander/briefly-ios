//
//  ArticleSignalsView.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import SwiftUI

struct ArticleSignalsView: View {

    let article: Article

    var body: some View {
        HStack {
            Text(article.topic.displayName)
                .font(.caption)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.blue.opacity(0.12))
                .clipShape(Capsule())

            Spacer()

            if article.score > 0 {
                Label("\(article.score)", systemImage: "arrow.up")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
