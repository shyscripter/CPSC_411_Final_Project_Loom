//
//  MyList+CoreDataProperties.swift
//  Loom
//
//  Created by Aaron Haight on 12/4/25.
//

// This file would typically be automatically generated when making new objects using CoreData
// However, we needed to make this file manually because we use the UIColor data type when storing lists (categories)
// Which is why we need to import UIKit, to get access to UIColor as a data type

import Foundation
import CoreData
import UIKit

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
