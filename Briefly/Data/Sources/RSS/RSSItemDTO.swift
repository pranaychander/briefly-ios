//
//  RSSItemDTO.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

struct RSSItemDTO {
    let title: String
    let link: String
    let author: String?
    let publishedDate: Date?
    let description: String?
    var topic: String
    let thumbnailURL: URL?
}

