//
//  Date+Extensions.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation

// Custom extensions for easier reminder display using the existing Date data type
extension Date {
    
    // Function to find whether a date falls under the current day in real-time
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    // Added function to find whether a date falls under the next day in real-time
    var isTomorrow: Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
    
    // Quicker reference to a date's components for better readability
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
}
