//
//  PreviewData.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation
import CoreData

class PreviewData {
    
    static var myList: MyList {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? MyList()
    }
    
}
