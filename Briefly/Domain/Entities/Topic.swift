//
//  Topic.swift
//  Briefly
//
//  Created by Pranay Chander on 14/01/26.
//

import Foundation

enum Topic: String, CaseIterable, Identifiable, Hashable {
    case technology
    case business
    case sports
    case science
    case entertainment

    var id: String { rawValue }
    
    var displayName: String { rawValue.capitalized }
}


extension Topic {
    func toRedditSubreddit() -> String {
        switch self {
        case .technology: return "technology"
        case .business: return "business"
        case .science: return "science"
        case .sports: return "sports"
        case .entertainment: return "entertainment"
        }
    }
}

extension Topic {
    var rssPath: String {
        switch self {
        case .technology:
            return "/news/technology/rss.xml"
        case .business:
            return "/news/business/rss.xml"
        case .science:
            return "/news/science_and_environment/rss.xml"
        case .sports:
            return "/sport/rss.xml"
        case .entertainment:
            return "/news/entertainment_and_arts/rss.xml"
        }
    }
}

typealias TopicSelection = Set<Topic>
