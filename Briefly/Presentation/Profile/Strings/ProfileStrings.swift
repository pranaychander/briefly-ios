//
//  ProfileStrings.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import Foundation

enum ProfileStrings {

    static let title = String(localized: "profile.title")
    static let guestUser = String(localized: "profile.guestUser")
    static let personalizeFeed = String(localized: "profile.personalizeFeed")

    enum Sections {
        static let topics = String(localized: "profile.sections.topics")
        static let contentPreferences = String(localized: "profile.sections.contentPreferences")
        static let appSettings = String(localized: "profile.sections.appSettings")
        static let about = String(localized: "profile.sections.about")
    }

    enum Toggles {
        static let autoRefresh = String(localized: "profile.toggle.autoRefresh")
        static let offlineMode = String(localized: "profile.toggle.offlineMode")
    }

    enum About {
        static let version = String(localized: "profile.about.version")
        static let privacyPolicy = String(localized: "profile.about.privacyPolicy")
    }
}
