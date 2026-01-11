//
//  AppConfig.swift
//  Briefly
//
//  Created by Pranay Chander on 08/01/26.
//

import Foundation

// Core/AppConfig.swift
struct AppConfig {
    static let hackerNewsBaseURL: URL = {
        print("CONFIG:", Bundle.main.object(forInfoDictionaryKey: "APP_ENV") ?? "nil")

        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "HN_BASE_URL") as? String,
              let url = URL(string: "https://\(urlString)") else {
            fatalError("HN_BASE_URL not configured")
        }
        return url
    }()

    static let redditBaseURL: URL = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "REDDIT_BASE_URL") as? String,
              let url = URL(string: "https://\(urlString)") else {
            fatalError("REDDIT_BASE_URL not configured")
        }
        return url
    }()

    static let rssTechFeed: URL = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "RSS_TECH_FEED") as? String,
              let url = URL(string: "https://\(urlString)") else {
            fatalError("RSS_TECH_FEED not configured")
        }
        return url
    }()
}
