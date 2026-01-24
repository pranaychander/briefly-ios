//
//  ProfileStrings.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import Foundation

import Foundation

enum ProfileStrings {

    static let title = LocalizedStringResource(
        "profile.title",
        comment: "Profile screen title"
    )

    static let guestUser = LocalizedStringResource(
        "profile.guestUser",
        comment: "Guest user label"
    )

    static let personalizeFeed = LocalizedStringResource(
        "profile.personalizeFeed",
        comment: "Subtitle under profile name"
    )

    enum Sections {
        static let topics = LocalizedStringResource("profile.sections.topics")
        static let contentPreferences = LocalizedStringResource("profile.sections.contentPreferences")
        static let appSettings = LocalizedStringResource("profile.sections.appSettings")
        static let about = LocalizedStringResource("profile.sections.about")
    }

    enum Toggles {
        static let autoRefresh = LocalizedStringResource("profile.toggle.autoRefresh")
        static let offlineMode = LocalizedStringResource("profile.toggle.offlineMode")
    }

    enum About {
        static let version = LocalizedStringResource("profile.about.version")
        static let privacyPolicy = LocalizedStringResource("profile.about.privacyPolicy")
    }
}
