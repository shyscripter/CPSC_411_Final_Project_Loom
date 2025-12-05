//
//  ReminderService.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation
import CoreData
import UIKit

class ReminderService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    // Helper function for faster writing
    static func save() throws {
        try viewContext.save()
    }
    
    // Create a function to save a list
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
}
