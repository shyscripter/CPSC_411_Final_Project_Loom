//
//  ReminderListView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct ReminderListView: View {
    
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    let reminders: FetchedResults<Reminder>
    
    // Function up here because i like cleaner code
    private func reminderCheckedChange(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        return (selectedReminder?.objectID == reminder.objectID)
    }
    
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
        VStack {
            List {
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                        switch event {
                            case .onSelect(let reminder):
                                selectedReminder = reminder
                            case .onCheckedChange(let reminder, let isCompleted):
                                reminderCheckedChange(reminder: reminder, isCompleted: isCompleted)
                            case .onInfo:
                                showReminderDetail = true
                        }
                    }
                }.onDelete(perform: deleteReminder)
            }
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
