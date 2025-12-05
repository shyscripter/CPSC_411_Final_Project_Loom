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
            ReminderCellView(reminder: reminder) { event in
                switch event {
                    case .onSelect(let reminder):
                        print("ON SELECTED")
                    case .onCheckedChange(let reminder):
                        print("ON CHECKED CHANGE")
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
