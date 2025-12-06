//
//  MyList+CoreDataClass.swift
//  Loom
//
//  Created by Aaron Haight on 12/4/25.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { ($0 as! Reminder) } ?? []
    }
    
}
