//
//  Comment.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import Foundation

struct Comment: Identifiable, Hashable {
    let id: String
    let author: String
    let body: String
    let score: Int
    let createdAt: Date
}
