//
//  SaveSelectedTopicsUseCase.swift
//  Briefly
//
//  Created by Pranay Chander on 14/01/26.
//

import Foundation

struct SaveSelectedTopicsUseCase {

    private let repository: TopicPreferenceRepository

    init(repository: TopicPreferenceRepository) {
        self.repository = repository
    }

    func execute(_ topics: Set<Topic>) {
        repository.saveSelectedTopics(topics)
    }
}
