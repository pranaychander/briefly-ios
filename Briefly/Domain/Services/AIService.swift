//
//  AIService.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import Foundation

protocol AIService {
    func generate(using builder: AIPromptBuilder) async throws -> String
}
