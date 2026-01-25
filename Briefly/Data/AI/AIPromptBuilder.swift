//
//  AIPromptBuilder.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//
import Foundation

protocol AIPromptBuilder {
    var instructions: String { get }
    var prompt: String { get }
}
