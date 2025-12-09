//
//  MyList+CoreDataClass.swift
//  Loom
//
//  Created by Aaron Haight on 12/4/25.
//

// This file would typically be automatically generated when making new objects using CoreData
// However, we needed to make this file manually because we use the UIColor data type when storing lists (categories)

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { ($0 as! Reminder) } ?? []
    }
    
}
