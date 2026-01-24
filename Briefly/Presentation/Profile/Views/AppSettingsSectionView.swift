//
//  AppSettingsSectionView.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import SwiftUI

struct AppSettingsSectionView: View {

    var body: some View {
        Section(header: Text(ProfileStrings.Sections.appSettings)) {
            NavigationLink("Notifications") {
                Text("Notification Settings")
            }

            NavigationLink("Appearance") {
                Text("Theme Settings")
            }
        }
    }
}
