//
//  ContentPreferencesSectionView.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import SwiftUI

struct ContentPreferencesSectionView: View {

    let isAutoRefreshEnabled: Bool
    let isOfflineModeEnabled: Bool

    let onAutoRefreshToggle: (Bool) -> Void
    let onOfflineModeToggle: (Bool) -> Void

    var body: some View {
        Section(header: Text(ProfileStrings.Sections.contentPreferences)) {

            Toggle(
                ProfileStrings.Toggles.autoRefresh,
                isOn: Binding(
                    get: { isAutoRefreshEnabled },
                    set: onAutoRefreshToggle
                )
            )

            Toggle(
                ProfileStrings.Toggles.offlineMode,
                isOn: Binding(
                    get: { isOfflineModeEnabled },
                    set: onOfflineModeToggle
                )
            )
        }
    }
}
