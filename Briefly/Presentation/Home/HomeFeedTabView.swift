//
//  HomeFeedTabView.swift
//  Briefly
//
//  Created by Pranay Chander on 17/01/26.
//

import SwiftUI

struct HomeFeedTabView: View {

    let title: String
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundColor(isSelected ? .primary : .secondary)

            Rectangle()
                .fill(isSelected ? Color.gray : Color.clear)
                .frame(height: 2)
                .cornerRadius(1)
        }
    }
}
