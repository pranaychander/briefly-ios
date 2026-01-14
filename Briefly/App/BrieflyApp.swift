//
//  BrieflyApp.swift
//  Briefly
//
//  Created by Pranay Chander on 14/12/25.
//

import SwiftUI
import CoreData

@main
struct BrieflyApp: App {

    private let container = DependencyContainer()

    var body: some Scene {
        WindowGroup {
            FeedView(
                viewModel: FeedViewModel(
                    getTopics: container.getSelectedTopicsUseCase,
                    saveTopics: container.saveSelectedTopicsUseCase,
                    aggregateUseCase: container.aggregateArticlesUseCase
                )
            )
        }
    }
}

