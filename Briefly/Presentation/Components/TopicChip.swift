//
//  TopicChip.swift
//  Briefly
//
//  Created by Pranay Chander on 14/01/26.
//

import SwiftUI

struct TopicChip: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        Text(title)
            .font(.subheadline.bold())
            .padding(.vertical, 6)
            .padding(.horizontal, 14)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.blue : Color.gray.opacity(0.2))
            )
            .foregroundColor(isSelected ? .white : .primary)
            .animation(.spring(), value: isSelected)
    }
}
