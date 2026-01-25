//
//  ReadFullArticleButton.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import SwiftUI
import WebKit

struct ReadFullArticleButton: View {
    let url: URL
    var body: some View {
        NavigationLink(destination: WebView(url: url)) {
            Text("Read Full Article")
                .fontWeight(.semibold)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}
