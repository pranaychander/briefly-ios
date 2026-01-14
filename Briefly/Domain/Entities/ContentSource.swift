//
//  ContentSource.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation
import SwiftUI

enum ContentSource: String {
    case hackerNews
    case reddit
    case rss
}

extension ContentSource {
    var displayName: String {
        switch self {
        case .reddit: return "Reddit"
        case .hackerNews: return "Hacker News"
        case .rss: return "RSS"
        }
    }
    
    var color: Color {
        switch self {
        case .hackerNews: return .orange
        case .reddit: return .red
        case .rss: return .blue
        }
    }
}
