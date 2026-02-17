//
//  Secrets.swift
//  Briefly
//
//  Created by Pranay Chander on 05/02/26.
//

import Foundation

enum Secrets {
    static let rapidAPIKey: String = {
        guard let key = Bundle.main.object(
            forInfoDictionaryKey: "RAPID_API_KEY"
        ) as? String else {
            fatalError("Missing RAPID_API_KEY in Info.plist")
        }
        return key
    }()
}
