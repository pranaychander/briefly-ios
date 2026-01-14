//
//  Date+Extension.swift
//  Briefly
//
//  Created by Pranay Chander on 14/01/26.
//

import Foundation

extension Date {
    var relativeDescription: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
