//
//  TopicPreferenceRepository.swift
//  Briefly
//
//  Created by Pranay Chander on 14/01/26.
//

import Foundation

protocol TopicPreferenceRepository {
    func loadSelectedTopics() -> Set<Topic>
    func saveSelectedTopics(_ topics: Set<Topic>)
}
