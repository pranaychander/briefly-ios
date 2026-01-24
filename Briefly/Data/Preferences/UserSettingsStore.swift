//
//  UserSettingsStore.swift
//  Briefly
//
//  Created by Pranay Chander on 17/01/26.
//

import Foundation
import Combine

@MainActor
final class UserSettingsStore: ObservableObject {

    @Published var state: UserSettings

    private let repository: UserSettingsRepository

    init(initialState: UserSettings, repository: UserSettingsRepository) {
        self.state = initialState
        self.repository = repository
    }

    // MARK: - Topic mutations

    func toggleTopic(_ topic: Topic) {
        guard state.selectedTopics.count > 1 || !state.selectedTopics.contains(topic) else {
            return
        }

        if state.selectedTopics.contains(topic) {
            state.selectedTopics.remove(topic)
        } else {
            state.selectedTopics.insert(topic)
        }

        persist()
    }

    func setTopics(_ topics: Set<Topic>) {
        state.selectedTopics = topics
        persist()
    }

    // MARK: - Appearance

    func setTheme(_ theme: AppTheme) {
        state.theme = theme
        persist()
    }

    func setFontScale(_ scale: FontScale) {
        state.fontScale = scale
        persist()
    }

    // MARK: - Behavior

    func setOfflineMode(_ enabled: Bool) {
        state.offlineModeEnabled = enabled
        persist()
    }

    func setAutoRefresh(_ enabled: Bool) {
        state.autoRefreshEnabled = enabled
        persist()
    }

    // MARK: - Notifications

    func setNotificationsEnabled(_ enabled: Bool) {
        state.notificationsEnabled = enabled
        persist()
    }

    // MARK: - Lifecycle

    func completeOnboarding() {
        state.hasCompletedOnboarding = true
        persist()
    }

    private func persist() {
        repository.save(state)
    }
}

