//
//  Logger.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import os
import Foundation

extension Logger {
    static let feed = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "Briefly",
        category: "Feed"
    )
}
