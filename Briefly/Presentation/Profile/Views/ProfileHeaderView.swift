//
//  ProfileHeaderView.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import SwiftUI

struct ProfileHeaderView: View {

    var body: some View {
        Section {
            HStack(spacing: 16) {
                Circle()
                    .fill(.gray.opacity(0.3))
                    .frame(width: 56, height: 56)
                    .overlay(Text("P").font(.title))

                VStack(alignment: .leading) {
                    Text(ProfileStrings.guestUser)
                        .font(.headline)

                    Text(ProfileStrings.personalizeFeed)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 8)
        }
    }
}
