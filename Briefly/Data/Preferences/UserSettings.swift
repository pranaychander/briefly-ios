//
//  UserSettings.swift
//  Briefly
//
//  Created by Pranay Chander on 17/01/26.
//

import Foundation

struct UserSettings: Codable, Equatable {

    // Personalization
    var selectedTopics: Set<Topic> = [.technology]
    var preferredSources: Set<ContentSource>

    // Appearance
    var theme: AppTheme
    var fontScale: FontScale
    var dynamicTypeEnabled: Bool

    // App behavior
    var autoRefreshEnabled: Bool
    var offlineModeEnabled: Bool

    // Notifications (preferences only)
    var notificationsEnabled: Bool
    var dailyDigestTime: DateComponents?

    // Localization
    var preferredLanguage: AppLanguage

    // User lifecycle
    var hasCompletedOnboarding: Bool
    var isLoggedIn: Bool
}

extension UserSettings {
    static let `default` = UserSettings(
        selectedTopics: [.technology],
        preferredSources: [.hackerNews, .reddit, .rss],
        theme: .system,
        fontScale: .medium,
        dynamicTypeEnabled: true,
        autoRefreshEnabled: true,
        offlineModeEnabled: false,
        notificationsEnabled: true,
        dailyDigestTime: nil,
        preferredLanguage: .system,
        hasCompletedOnboarding: false,
        isLoggedIn: false
    )
}
