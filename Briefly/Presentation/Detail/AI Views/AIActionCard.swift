//
//  AIActionCard.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import SwiftUI

struct AIActionCard: View {
    let action: AIAction

    var body: some View {
        HStack(spacing: 14) {

            Image(systemName: action.icon)
                .font(.title2)
                .frame(width: 36)
                .foregroundStyle(.blue)

            VStack(alignment: .leading, spacing: 4) {
                Text(action.title)
                    .font(.headline)

                Text(action.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(14)
    }
}
