//
//  UIColorTransformer.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation
import UIKit

// Transforms types for compatibility with ReminderModel
class UIColorTransformer: ValueTransformer {
    
    // Archives passed data
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    // Takes the data and unarchives it
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        
        guard let data = value as? Data else { return nil }
        
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            return color
        } catch {
            return nil
        }
        
    }
    
}
