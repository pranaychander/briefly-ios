//
//  ReadOriginalButton.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import SwiftUI

struct ReadOriginalButton: View {

    let urlString: String?

    var body: some View {
        if let urlString,
           let url = URL(string: urlString) {

            Link(destination: url) {
                Label("Read full article", systemImage: "safari")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}
