//
//  RedditPostDTO.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

struct RedditListingDTO: Decodable {
    let data: RedditListingData
}

struct RedditListingData: Decodable {
    let children: [RedditChild]
}

struct RedditChild: Decodable {
    let data: RedditPostDTO
}

struct RedditPostDTO: Decodable {
    let id: String
    let title: String
    let url: String
    let author: String
    let created_utc: TimeInterval
    let score: Int
    let topic: String?
    let thumbnail: String?
    let selftext: String?
    let preview: RedditPreviewDTO?
    var comments: [RedditCommentDTO]? = []
}

struct RedditPreviewDTO: Decodable {
    let images: [RedditImageDTO]
}

struct RedditImageDTO: Decodable {
    let source: RedditImageSourceDTO
    let resolutions: [RedditImageSourceDTO]
}

struct RedditImageSourceDTO: Decodable {
    let url: String
    let width: Int
    let height: Int
}

extension RedditPostDTO {
    var contentPreview: String? {
        guard let text = selftext, !text.isEmpty else {
            return nil
        }
        
        return text.replacingOccurrences(of: "\n\n", with: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var bestImageURL: URL? {
        if let url = preview?.images.first?.resolutions.last?.url.redditSanitizedURL {
            return url
        }
        guard let thumb = thumbnail, thumb.starts(with: "http") else { return nil }
        return thumb.redditSanitizedURL
    }
}
