//
//  ArticleTitleView.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import SwiftUI

struct ArticleTitleView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .padding(.horizontal)
    }
}
