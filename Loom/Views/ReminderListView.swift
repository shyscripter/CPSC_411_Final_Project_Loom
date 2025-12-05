//
//  ReminderListView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    // Function up here because i like cleaner code
    private func reminderCheckedChange(reminder: Reminder) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = !reminder.isCompleted
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                    case .onSelect(let reminder):
                        print("ON SELECTED")
                    case .onCheckedChange(let reminder):
                        reminderCheckedChange(reminder: reminder)
                    case .onInfo:
                        print("ON INFO")
                }
            }
        }
    }
}

/*
 #Preview {
 ReminderListView()
 }
 */
