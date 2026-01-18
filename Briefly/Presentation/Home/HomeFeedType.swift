//
//  HomeFeedType.swift
//  Briefly
//
//  Created by Pranay Chander on 17/01/26.
//

import Foundation

enum HomeFeedType: Hashable {

    case forYou
    case topic(Topic)

    static var allCases: [HomeFeedType] {
        [.forYou] + Topic.allCases.map { .topic($0) }
    }

    var displayName: String {
        switch self {
        case .forYou:
            return "For You"
        case .topic(let topic):
            return topic.displayName
        }
    }

    var topic: Topic? {
        if case .topic(let topic) = self { return topic }
        return nil
    }

    var isForYou: Bool {
        if case .forYou = self { return true }
        return false
    }
}
