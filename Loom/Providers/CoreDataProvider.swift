//
//  CoreDataProvider.swift
//  Loom
//
//  Created by Aaron Haight on 12/4/25.
//

import Foundation
import CoreData

// Class is responsible for setting up the CoreData upon app loading
class CoreDataProvider {
    
    // We only want one instance of this provider
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    // Private constructor to make sure there's only one provider
    private init() {
        
        // Register transformers
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        // Create a persistent container, app crashes if this model doesn't exist
        persistentContainer = NSPersistentContainer(name: "ReminderModel")
        persistentContainer.loadPersistentStores() { desc, error in
            if let error {
                fatalError("Error initializing ReminderModel \(error)")
            }
            
        }
        
    }
    
}
