//
//  GetSelectedTopicsUseCase.swift
//  Briefly
//
//  Created by Pranay Chander on 14/01/26.
//

import Foundation

struct GetSelectedTopicsUseCase {

    private let repository: TopicPreferenceRepository

    init(repository: TopicPreferenceRepository) {
        self.repository = repository
    }

    func execute() -> Set<Topic> {
        repository.loadSelectedTopics()
    }
}
