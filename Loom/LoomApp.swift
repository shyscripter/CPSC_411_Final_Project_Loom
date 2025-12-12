//
//  LoomApp.swift
//  Loom
//
//  Created by Aaron Haight on 11/24/25.
//

import SwiftUI
import UserNotifications

@main
struct LoomApp: App {
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    // Request permission for notifications to be enabled on app startup
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                // Notificaitons are allowed
            } else {
                // TODO: Display a message to the user
            }
            
        }
    }
    
    
    // Call for the rest of the UI and data to show up
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext,
                             CoreDataProvider.shared.persistentContainer.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
    
    
    
    
    

