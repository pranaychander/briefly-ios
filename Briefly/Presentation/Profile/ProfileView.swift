//
//  ProfileView.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject private var userSettingsStore: UserSettingsStore

    var body: some View {
        List {
            profileHeaderSection
            topicsSection
            contentPreferencesSection
            appSettingsSection
            aboutSection
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Profile")
    }
}


private extension ProfileView {

    var profileHeaderSection: some View {
        Section {
            HStack(spacing: 16) {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 56, height: 56)
                    .overlay(Text("P").font(.title))

                VStack(alignment: .leading) {
                    Text("Guest User")
                        .font(.headline)
                    Text("Personalize your feed")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

private extension ProfileView {

    var topicsSection: some View {
        Section(header: Text("Topics")) {
            ForEach(Topic.allCases) { topic in
                Toggle(
                    topic.displayName,
                    isOn: Binding(
                        get: {
                            userSettingsStore.state.selectedTopics.contains(topic)
                        },
                        set: { _ in
                            userSettingsStore.toggleTopic(topic)
                        }
                    )
                )
            }
        }
    }
}

private extension ProfileView {

    var contentPreferencesSection: some View {
        Section(header: Text("Content Preferences")) {

            Toggle(
                "Auto Refresh Feed",
                isOn: Binding(
                    get: {
                        userSettingsStore.state.autoRefreshEnabled
                    },
                    set: { enabled in
                        userSettingsStore.setAutoRefresh(enabled)
                    }
                )
            )

            Toggle(
                "Offline Mode",
                isOn: Binding(
                    get: {
                        userSettingsStore.state.offlineModeEnabled
                    },
                    set: { enabled in
                        userSettingsStore.setOfflineMode(enabled)
                    }
                )
            )
        }
    }
}

private extension ProfileView {

    var appSettingsSection: some View {
        Section(header: Text("App Settings")) {

            NavigationLink("Notifications") {
                Text("Notification Settings")
            }

            NavigationLink("Appearance") {
                Text("Theme Settings")
            }
        }
    }
}

private extension ProfileView {

    var aboutSection: some View {
        Section(header: Text("About")) {

            HStack {
                Text("Version")
                Spacer()
                Text("1.0.0")
                    .foregroundColor(.secondary)
            }

            NavigationLink("Privacy Policy") {
                Text("Privacy Policy")
            }
        }
    }
}
