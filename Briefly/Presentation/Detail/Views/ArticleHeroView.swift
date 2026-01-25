//
//  ArticleHeroView.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import SwiftUI

struct ArticleHeroView: View {
    let url: URL
    var body: some View {
        GeometryReader { geo in
            AsyncImage(url: url) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .frame(height: 220)
        .clipped()
        .cornerRadius(12)
    }
}
