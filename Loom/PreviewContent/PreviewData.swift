//
//  PreviewData.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation
import CoreData

// Class to allow the data to be previewed in-app
// PreviewData's values are sent to the preview function for ease of use when working on new features
class PreviewData {
    
    static var myList: MyList {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? MyList()
    }
    
    static var reminder: Reminder {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = Reminder.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? Reminder(context: viewContext)
    }
    
}
