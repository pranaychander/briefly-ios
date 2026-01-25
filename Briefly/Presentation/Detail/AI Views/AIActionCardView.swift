//
//  AIActionCardView.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import SwiftUI

struct AIActionCardView: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "sparkles").foregroundColor(.cyan)
                VStack(alignment: .leading, spacing: 2) {
                    Text("BRU – Your AI Assistant")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("Summarize, tweet, or share insights")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.gray)
            }
            .padding()
            .background(Color.cyan.opacity(0.1))
            .cornerRadius(12)
        }
    }
}
