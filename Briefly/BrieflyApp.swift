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
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
