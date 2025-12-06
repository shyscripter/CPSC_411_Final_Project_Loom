//
//  NotificationManager.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation
import UserNotifications

// Struct for user data
struct UserData {
    let title: String?
    let body: String?
    let date: Date?
    let time: Date?
}

// Responsible for scheduling notifications
class NotificationManager {
    
    static func scheduleNotificaiton(userData: UserData) {
        
        let content = UNMutableNotificationContent()
        content.title = userData.title ?? "Reminder"
        content.body = userData.body ?? "" // Reminder notes
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userData.date ?? Date())
        
        if let reminderTime = userData.time {
            let reminderTimeComponents = reminderTime.dateComponents
            dateComponents.hour = reminderTimeComponents.hour
            dateComponents.minute = reminderTimeComponents.minute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Loom Reminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
}
