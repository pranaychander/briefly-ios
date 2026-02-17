//
//  UserSettingsRepository.swift
//  Briefly
//
//  Created by Pranay Chander on 18/01/26.
//

import Foundation

protocol UserSettingsRepository {
    func load() -> UserSettings
    func save(_ settings: UserSettings)
}
