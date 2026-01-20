//
//  String+Extension.swift
//  Briefly
//
//  Created by Pranay Chander on 20/01/26.
//

import Foundation

extension String {
    var redditSanitizedURL: URL? {
        let decoded = self.replacingOccurrences(of: "&amp;", with: "&")
        return URL(string: decoded)
    }
}
