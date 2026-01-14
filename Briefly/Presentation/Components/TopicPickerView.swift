//
//  TopicPickerView.swift
//  Briefly
//
//  Created by Pranay Chander on 14/01/26.
//

import SwiftUI

struct TopicPickerView: View {

    let topics: [Topic]
    @Binding var selection: Set<Topic>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(topics, id: \.self) { topic in
                    TopicChip(
                        title: topic.displayName,
                        isSelected: selection.contains(topic)
                    )
                    .onTapGesture {
                        toggle(topic)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private func toggle(_ topic: Topic) {
        withAnimation(.spring()) {
            if selection.contains(topic), selection.count > 1 {
                selection.remove(topic)
            } else {
                selection.insert(topic)
            }
        }
    }
}
