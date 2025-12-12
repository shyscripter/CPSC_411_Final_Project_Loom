//
//  ReminderDetailView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct ReminderDetailView: View {
    
    // Variables to allow dismissing, selecting, and saving of reminder details
    @Environment(\.dismiss) private var dismiss
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    // Don't allow reminders to be edited with empty names
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        
        // Buttons in this view should link to another sub-menu
        NavigationView {
            
            // Stack details of the reminder under a list, to display attributes in order
            VStack {
                
                // Allows displaying of attributes in sections (for each property)
                List {
                    
                    // Handle title and notes as editable texts, notes being optional
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    
                    // Handle date and time as toggleable attributes
                    Section {
                        
                        // Toggle whether the date is scheduled
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }
                        
                        // Let the user pick a new data
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        // Toggle whether the time is scheduled
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }
                        
                        // Let the user pick a new time for the notification
                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        
                        // Last section to handle reassigning the reminder to a new list (category)
                        Section {
                            NavigationLink {
                                SelectListView(selectedList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("Category")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }
                        }
                        
                    // Edit the reminder's date in the database when changed by the user
                    }
                    .onChange(of: editConfig.hasDate) { oldValue, newValue in
                        if newValue {
                            editConfig.reminderDate = Date()
                        }
                    
                    // Edit the reminder's time in the database when changed by the user
                    }.onChange(of: editConfig.hasTime) { oldValue, newValue in
                        if newValue {
                            editConfig.reminderTime = Date()
                        }
                    }
                }.listStyle(.insetGrouped)
            
            // Overwrite current config with a new config when this view is loaded
            }.onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            
            // Toolbar on the top to allow saving of the reminder with a done button
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        do {
                            
                            // Try to update the reminder through custom library
                            let updated = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                            
                            if updated {
                                
                                // Check if we should schedule a notification
                                if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                    let userData = UserData(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime)
                                    NotificationManager.scheduleNotificaiton(userData: userData)
                                }
                                
                            }
                            
                        } catch {
                            print(error)
                        }
                        
                        // Dismiss navigation when done
                        dismiss()
                    }.disabled(!isFormValid)
                }
                
                // Cancel button to dismiss the editing of a reminder without saving
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
            }
        }
    }
}

// Preview functionality
#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
