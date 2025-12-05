//
//  ReminderListView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        List(reminders) { reminder in
            Text(reminder.title ?? "")
        }
    }
}

/*
 #Preview {
 ReminderListView()
 }
 */
