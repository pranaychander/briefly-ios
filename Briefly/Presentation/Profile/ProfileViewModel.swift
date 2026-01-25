//
//  ProfileViewModel.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import Foundation

@MainActor
final class ProfileViewModel {
    let sections: [ProfileSection] = [
        .header,
        .topics,
        .contentPreferences,
        .appSettings,
        .about
    ]
}

