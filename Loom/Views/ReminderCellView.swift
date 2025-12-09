//
//  ReminderCellView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

// Represents each type of action we can make for closures which can be fired
enum ReminderCellEvents {
    case onInfo
    case onCheckedChange(Reminder, Bool)
    case onSelect(Reminder)
}

struct ReminderCellView: View {
    
    // Reminder and delay variables to allow user control of the object
    let reminder: Reminder
    let delay = Delay()
    let isSelected: Bool
    
    // Events
    @State private var checked: Bool = false
    let onEvent: (ReminderCellEvents) -> Void
    
    // Utility function to display upcoming times instead of exact dates when close enough to the current time
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        
        // Let the checked toggle be on the very left and move everything else to the right of the cell
        HStack {
            
            // Toggleable button to click when the reminder is completed
            Image(systemName: checked ? "circle.inset.filled": "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture{
                    checked.toggle()
                    
                    // Cancel the old task then call a new delay when the circle is toggled
                    delay.cancel()
                    delay.performWork {
                       onEvent(.onCheckedChange(reminder, checked))
                    }
                }
            
            // Vertically stack all components for date and time
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
                
                // Horizontal stack to show the date and time next to each other
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formatDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .opacity(0.4)
            }
            
            // Empty space in between
            Spacer()
            
            // When tapping the info circle on the right, open the details of the reminder
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1.0 : 0.0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        // When loaded, correctly assign the checked flag
        .onAppear {
            checked = reminder.isCompleted
        }
        // Makes the whole thing clickable instead of just the buttons when selecting a reminder
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
        }
    }
}

// Preview functionality
#Preview {
    ReminderCellView(reminder: PreviewData.reminder, isSelected: false, onEvent: {_ in })
}
