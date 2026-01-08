//
//  RedditScoreStrategy.swift
//  Briefly
//
//  Created by Pranay Chander on 31/12/25.
//

import Foundation

protocol ScoringStrategy {
    func score(article: Article) -> Int
}

struct RedditScoreStrategy: ScoringStrategy {
    func score(article: Article) -> Int {
        article.score
    }
}
