//
//  ProfileSection.swift
//  Briefly
//
//  Created by Pranay Chander on 24/01/26.
//

import Foundation

enum ProfileSection: CaseIterable, Identifiable {
    case header
    case topics
    case contentPreferences
    case appSettings
    case about

    var id: Self { self }
}
