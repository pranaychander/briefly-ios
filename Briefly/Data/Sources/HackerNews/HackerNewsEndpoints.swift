//
//  HackerNewsEndpoints.swift
//  Briefly
//
//  Created by Pranay Chander on 31/12/25.
//

import Foundation

enum HackerNewsEndpoint: APIEndpoint {

    case stories(StoryType)
    case item(id: Int)

    enum StoryType {
        case top
        case new
        case best
    }
    
    var method: HTTPMethod {
        .get
    }

    var baseURL: URL {
        AppConfig.hackerNewsBaseURL
    }

    var path: String {
        switch self {
        case .stories(.top):
            return "topstories.json"
        case .stories(.new):
            return "newstories.json"
        case .stories(.best):
            return "beststories.json"
        case .item(let id):
            return "item/\(id).json"
        }
    }

    var queryItems: [URLQueryItem] {
        []
    }
}

