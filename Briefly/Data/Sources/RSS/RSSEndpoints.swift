//
//  RSSEndpoints.swift
//  Briefly
//
//  Created by Pranay Chander on 07/01/26.
//

import Foundation

enum RSSEndpoint: APIEndpoint {

    case feed(topic: Topic)
    case custom(URL)

    var method: HTTPMethod {
        .get
    }

    var baseURL: URL {
        switch self {
        case .feed:
            return AppConfig.rssBaseURL
        case .custom(let url):
            return url.deletingLastPathComponent()
        }
    }

    var path: String {
        switch self {
        case .feed(let topic):
            return topic.rssPath
        case .custom(let url):
            return "/" + url.lastPathComponent
        }
    }

    var queryItems: [URLQueryItem] {
        []
    }
}
