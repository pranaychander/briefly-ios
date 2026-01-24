//
//  TopicsSectionView.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import SwiftUI

struct TopicsSectionView: View {

    let selectedTopics: Set<Topic>
    let onToggle: (Topic) -> Void

    var body: some View {
        Section(header: Text(ProfileStrings.Sections.topics)) {
            ForEach(Topic.allCases) { topic in
                Toggle(
                    topic.displayName,
                    isOn: Binding(
                        get: { selectedTopics.contains(topic) },
                        set: { _ in onToggle(topic) }
                    )
                )
            }
        }
    }
}
