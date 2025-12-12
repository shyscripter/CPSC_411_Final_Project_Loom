//
//  ReminderService.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

// Custom service for reminder access
class ReminderService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    // Helper function for faster code writing
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
    
    // Updates the reminder in the database to newly passed attributes
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool {
        
        // Create a new reminder to pass to EditConfig
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        reminderToUpdate.title = editConfig.title
        reminderToUpdate.notes = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.reminderDate: nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.reminderTime : nil
        
        try save()
        return true
    }
    
    // Function to save a reminder to the database
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
    
    // Get all of the reminders in one specific list
    static func getRemindersByList(myList: MyList, includeCompleted: Bool) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        
        // Give a different predicate if the request asks for completed reminders too
        if includeCompleted {
            request.predicate = NSPredicate(format: "list = %@", myList)
        } else {
            request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", myList)
        }
        return request
    }
    
    // Delete a reminder from the database when the user prompts it to be deleted
    static func deleteReminder(_ reminder: Reminder) throws {
        viewContext.delete(reminder)
        try save()
    }
    
    // Get all reminders that fit within a searched term for the search bar
    static func getRemindersBySearchTerm(_ searchTerm: String) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchTerm)
        return request
    }
    
    // Fetch reminders according to a specific type, searching by attributes
    static func remindersByStatType(_ statType: ReminderStatType) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        
        switch statType {
            case .all:
                request.predicate = NSPredicate(format: "isCompleted = false")
            case .completed:
                request.predicate = NSPredicate(format: "isCompleted = true")
            case .scheduled:
                request.predicate = NSPredicate(format: "(reminderDate != nil OR reminderTime != nil) AND isCompleted = false")
            case .today:
                let today = Date()
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
                request.predicate = NSPredicate(format: "(reminderDate >= %@) AND (reminderDate < %@)", today as NSDate, tomorrow! as NSDate)
                                            
        }
        
        return request

    }
    
    // Delete a list by deleting all reminders the list has, then the list itself from the databse
    static func deleteList(_ myList: MyList) throws {
        
        // Find all reminders in this particular list
        let reminderResults = FetchRequest<Reminder>(fetchRequest: getRemindersByList(myList: myList, includeCompleted: false))
        
        // Delete every reminder inside of the list
        for reminder in reminderResults.wrappedValue {
            do {
                try deleteReminder(reminder)
            } catch {
                print(error)
            }
        }
        
        // Delete the list from the database once it is empty
        viewContext.delete(myList)
        try save()
    }
    
}
