//
//  ReminderListView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct ReminderListView: View {
    
    // Find the selected reminder and available reminders in list with flags
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    let reminders: FetchedResults<Reminder>
    
    // Function up here because i like cleaner code
    private func reminderCheckedChange(reminder: Reminder, isCompleted: Bool) {
        
        // Get current config when completion is toggled
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        // Try to update the reminder in the database with new configs
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    // Function to check whether a reminder is selected
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        return (selectedReminder?.objectID == reminder.objectID)
    }
    
    // Function to remove a reminder from the database
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder)
            } catch {
                print(error)
            }
        }
    }
    
    var body: some View {
        
        // Stack all reminders on top of each other
        VStack {
            
            // Create a new list so every object in this list can be deletable and stay sorted
            List {
                
                // Iterate through each reminder in the provided list
                ForEach(reminders) { reminder in
                    
                    // Create a new cell for this reminder
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                        
                        // Handle event-based edits to the database through switch cases
                        switch event {
                            case .onSelect(let reminder):
                                // Change selected reminder
                                selectedReminder = reminder
                            
                            case .onCheckedChange(let reminder, let isCompleted):
                                // Toggle the reminder's completion status
                                reminderCheckedChange(reminder: reminder, isCompleted: isCompleted)
                            
                            case .onInfo:
                                // Show reminder details when info is toggled
                                showReminderDetail = true
                        }
                    }
                    
                // Handle reminder removal with built-in UI functionality
                }.onDelete(perform: deleteReminder)
            }
        
        // Bind reminder detail display when the info button is clicked
        }.sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}

/*
 #Preview {
 ReminderListView()
 }
 */
