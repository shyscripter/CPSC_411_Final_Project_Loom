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
    
}

extension MyList: Identifiable {
    
}

// MARK: Generated accessors for notes
extension MyList {
    
}
