//
//  ReminderStatsBuilder.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation
import SwiftUI

// Holds teh values we want to display on the screen
struct ReminderStatsValues {
    var todayCount: Int = 0
    var scheduledCount: Int = 0
    var completedCount: Int = 0
    var allCount: Int = 0
}

// Develop the stats to display on the top side of the screen
struct ReminderStatsBuilder {
    
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        
        // Find all reminders in all lists in the database
        let remindersArray = myListResults.map { $0.remindersArray }.reduce([], +)
        
        // Get each count individually through functions then pass onto a constructor
        let all = allCount(reminders: remindersArray)
        let completed = completedCount(reminders: remindersArray)
        let today = todayCount(reminders: remindersArray)
        let scheduled = scheduledCount(reminders: remindersArray)
        
        return ReminderStatsValues(todayCount: today, scheduledCount: scheduled, completedCount: completed, allCount: all)
    }
    
    // Find all incomplete reminders
    private func allCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result + 1 : result
        }
    }
    
    // Find all completed reminders
    private func completedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }
    
    // Find all reminders scheduled for today
    private func todayCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1 : result
        }
    }
    
    // Find all reminders that have a schedule
    private func scheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let hasSchedule = (reminder.reminderDate != nil || reminder.reminderTime != nil)
            return hasSchedule ? result + 1 : result
        }
    }
    
}
