//
//  UserSettingsLocalRepository.swift
//  Briefly
//
//  Created by Pranay Chander on 18/01/26.
//

import Foundation

final class UserSettingsLocalRepository: UserSettingsRepository {

    private let key = "user_settings"

    func load() -> UserSettings {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let settings = try? JSONDecoder().decode(UserSettings.self, from: data)
        else {
            return UserSettings.default
        }

        return settings
    }

    func save(_ settings: UserSettings) {
        guard let data = try? JSONEncoder().encode(settings) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
