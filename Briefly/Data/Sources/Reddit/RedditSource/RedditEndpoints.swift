//
//  RedditEndpoints.swift
//  Briefly
//
//  Created by Pranay Chander on 07/01/26.
//

import Foundation

enum RedditEndpoint: APIEndpoint {

    case posts(PostCategory)

    enum PostCategory {
        case top(
            subreddit: String,
            limit: Int,
            timeRange: RedditTimeRange
        )
    }
    
    var method: HTTPMethod {
        .get
    }

    var baseURL: URL {
        AppConfig.redditBaseURL
    }

    var path: String {
        switch self {
        case .posts(.top(let subreddit, _, _)):
            return "/r/\(subreddit)/top.json"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .posts(.top(_, let limit, let timeRange)):
            return [
                .init(name: "limit", value: "\(limit)"),
                .init(name: "t", value: timeRange.rawValue)
            ]
        }
    }
}


