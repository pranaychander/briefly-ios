//
//  ProfileViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import Foundation

@MainActor
@Observable
final class ProfileViewModel {

    private let userSettingsStore: UserSettingsStore

    init(userSettingsStore: UserSettingsStore) {
        self.userSettingsStore = userSettingsStore
    }

    // MARK: - Structure

    var sections: [ProfileSection] {
        [.header, .topics, .contentPreferences, .appSettings, .about]
    }

    // MARK: - State (Read-only)

    var selectedTopics: Set<Topic> {
        userSettingsStore.state.selectedTopics
    }

    var isAutoRefreshEnabled: Bool {
        userSettingsStore.state.autoRefreshEnabled
    }

    var isOfflineModeEnabled: Bool {
        userSettingsStore.state.offlineModeEnabled
    }

    // MARK: - Intents

    func toggleTopic(_ topic: Topic) {
        userSettingsStore.toggleTopic(topic)
    }

    func setAutoRefresh(_ enabled: Bool) {
        userSettingsStore.setAutoRefresh(enabled)
    }

    func setOfflineMode(_ enabled: Bool) {
        userSettingsStore.setOfflineMode(enabled)
    }
}
