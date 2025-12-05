//
//  ReminderService.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation
import CoreData
import UIKit

// Custom service for reminder access
class ReminderService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    // Helper function for faster writing
    static func save() throws {
        try viewContext.save()
    }
    
    // Function to save a list
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
    // Function to save a reminder
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
    
    // Get the remidners in one specific list
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", myList)
        return request
    }
    
}
