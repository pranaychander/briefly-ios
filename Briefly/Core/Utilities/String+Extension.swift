//
//  String+Extension.swift
//  Briefly
//
//  Created by Pranay Chander on 20/01/26.
//

import Foundation
import SwiftUI

extension String {
    var redditSanitizedURL: URL? {
        let decoded = self.replacingOccurrences(of: "&amp;", with: "&")
        return URL(string: decoded)
    }
    
    var strippedHTML: String {
        let data = Data(self.utf8)
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        
        return (try? NSAttributedString(data: data, options: options, documentAttributes: nil))?.string.trimmingCharacters(in: .whitespacesAndNewlines) ?? self
    }
}
