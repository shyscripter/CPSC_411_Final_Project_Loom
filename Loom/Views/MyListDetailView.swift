//
//  MyListDetailView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct MyListDetailView: View {
    
    // Reference to the list we need details from
    let myList: MyList
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    
    // Find al of the reminders inside this specific list
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    
    // Flag for whether new reminders can be saved
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    // On initialization, find all reminders
    init(myList: MyList) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList, includeCompleted: false))
    }
    
    var body: some View {
        
        // Stack all reminders inside of this stack
        VStack {
            
            // Display list of Reminders in a separate view
            ReminderListView(reminders: reminderResults)
            
            // Button at the bottom of the list to add a new reminder
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminder = true
                }
            
            // Makes the plus button blue
            }.foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        
        // When plus button on the top-right is clicked, open an alert to add new reminder's information
        }.alert("New Reminder", isPresented: $openAddReminder) {
            
            // Empty text field
            TextField("", text: $title)
            
            // Button to cancel the operation on the alert
            Button("Cancel", role: .cancel) { }
            
            // Button to finish the operaiton and save the new reminder on the alert
            Button("Done") {
                if isFormValid {
                    do {
                        try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

// Preview functionality
#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
