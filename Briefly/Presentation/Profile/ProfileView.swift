//
//  ProfileView.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import SwiftUI

struct ProfileView: View {

    @State var viewModel: ProfileViewModel

    var body: some View {
        List {
            ForEach(viewModel.sections) { section in
                switch section {
                case .header:
                    ProfileHeaderView()

                case .topics:
                    TopicsSectionView(
                        selectedTopics: viewModel.selectedTopics,
                        onToggle: viewModel.toggleTopic
                    )

                case .contentPreferences:
                    ContentPreferencesSectionView(
                        isAutoRefreshEnabled: viewModel.isAutoRefreshEnabled,
                        isOfflineModeEnabled: viewModel.isOfflineModeEnabled,
                        onAutoRefreshToggle: viewModel.setAutoRefresh,
                        onOfflineModeToggle: viewModel.setOfflineMode
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
