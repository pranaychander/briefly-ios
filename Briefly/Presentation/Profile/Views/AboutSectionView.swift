//
//  AboutSectionView.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import SwiftUI

struct AboutSectionView: View {

    var body: some View {
        Section(header: Text(ProfileStrings.Sections.about)) {

            HStack {
                Text(ProfileStrings.About.version)
                Spacer()
                Text("1.0.0")
                    .foregroundStyle(.secondary)
            }

            NavigationLink(ProfileStrings.About.privacyPolicy) {
                Text("Privacy Policy")
            }
        }
    }
}
