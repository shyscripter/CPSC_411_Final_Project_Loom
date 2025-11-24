//
//  LoomApp.swift
//  Loom
//
//  Created by Aaron Haight on 11/24/25.
//

import SwiftUI

@main
struct LoomApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
