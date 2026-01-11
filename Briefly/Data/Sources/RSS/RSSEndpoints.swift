//
//  RSSEndpoints.swift
//  Briefly
//
//  Created by Pranay Chander on 07/01/26.
//

import Foundation

enum RSSEndpoint: APIEndpoint {

    case feed(FeedType)

    enum FeedType {
        case technology
        case custom(URL)
    }
    
    var method: HTTPMethod {
        .get
    }

    var baseURL: URL {
        switch self {
        case .feed(.technology):
            return AppConfig.redditBaseURL
        case .feed(.custom(let url)):
            return url.deletingLastPathComponent()
        }
    }

    var path: String {
        switch self {
        case .feed(.technology):
            return "/news/technology/rss.xml"
        case .feed(.custom(let url)):
            return url.lastPathComponent
        }
    }

    var queryItems: [URLQueryItem] {
        []
    }
}

