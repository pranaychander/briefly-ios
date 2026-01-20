//
//  HeroArticleView.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import SwiftUI

struct HeroArticleView: View {

    let article: Article

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {

                AsyncImage(url: article.thumbnailURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(
                    width: geo.size.width,
                    height: geo.size.height
                )
                .clipped()

                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(3)

                    Text("\(article.author) · \(article.publishedAt.relativeDescription)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding()
            }
        }
        .frame(height: 280)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}
