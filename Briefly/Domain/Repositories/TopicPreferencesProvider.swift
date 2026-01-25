//
//  TopicPreferencesProvider.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import Foundation

protocol TopicPreferencesProvider {
    var selectedTopics: Set<Topic> { get }
}

extension UserSettingsStore: TopicPreferencesProvider {
    var selectedTopics: Set<Topic> {
        state.selectedTopics
    }
}
