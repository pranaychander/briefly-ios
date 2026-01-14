//
//  TopicPreferenceLocalSource.swift
//  Briefly
//
//  Created by Pranay Chander on 14/01/26.
//

import Foundation

final class TopicPreferenceLocalSource: TopicPreferenceRepository {

    private let key = "selected_topics"

    func loadSelectedTopics() -> Set<Topic> {
        guard let rawValues = UserDefaults.standard.array(forKey: key) as? [String] else {
            return [.technology]
        }
        return Set(rawValues.compactMap(Topic.init))
    }

    func saveSelectedTopics(_ topics: Set<Topic>) {
        let values = topics.map(\.rawValue)
        UserDefaults.standard.set(values, forKey: key)
    }
}
