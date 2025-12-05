//
//  MyList+CoreDataProperties.swift
//  Loom
//
//  Created by Aaron Haight on 12/4/25.
//

import Foundation
import CoreData
import UIKit

// Manually created extension file for the class to allow the importing of UIKit
// This was done to make storing UIColor attributes through CoreData possible
extension MyList {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }
    
    @NSManaged public var name: String
    @NSManaged public var color: UIColor
    @NSManaged public var reminders: NSSet?
    
}

extension MyList: Identifiable {
    
}

// MARK: Generated accessors for notes
extension MyList {
    
    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)
    
    @objc(removeRemindersObject:)
    @NSManaged public func removeFromReminders(_ value: Reminder)
    
    @objc(addReminders:)
    @NSManaged public func addToReminders(_ values: NSSet)
    
    @objc(removeReminders:)
    @NSManaged public func removeFromReminder(_ values: NSSet)
}
