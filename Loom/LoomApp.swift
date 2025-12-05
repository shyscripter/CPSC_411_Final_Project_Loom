//
//  LoomApp.swift
//  Loom
//
//  Created by Aaron Haight on 11/24/25.
//

import SwiftUI

@main
struct LoomApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
