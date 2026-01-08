//
//  Article.swift
//  Briefly
//
//  Created by Pranay Chander on 21/12/25.
//

import Foundation

struct Article: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let url: String?
    let author: String
    let publishedAt: Date
    var score: Int
    let source: ContentSource
}

