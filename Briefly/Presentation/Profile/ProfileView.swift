//
//  ProfileView.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import SwiftUI

struct ProfileView: View {

    @Environment(UserSettingsStore.self) private var userSettings

    let viewModel: ProfileViewModel

    var body: some View {
        List {
            ForEach(viewModel.sections) { section in
                switch section {

                case .header:
                    ProfileHeaderView()

                case .topics:
                    TopicsSectionView(
                        selectedTopics: userSettings.state.selectedTopics,
                        onToggle: userSettings.toggleTopic
                    )

                case .contentPreferences:
                    ContentPreferencesSectionView(
                        isAutoRefreshEnabled: userSettings.state.autoRefreshEnabled,
                        isOfflineModeEnabled: userSettings.state.offlineModeEnabled,
                        onAutoRefreshToggle: { _ in
                            userSettings.toggleAutoRefresh()
                        },
                        onOfflineModeToggle: { _ in
                            userSettings.toggleOfflineMode()
                        }
                    )

                case .appSettings:
                    AppSettingsSectionView()

                case .about:
                    AboutSectionView()
                }
            }
        }
        .navigationTitle(ProfileStrings.title)
        .listStyle(.insetGrouped)
    }
}
