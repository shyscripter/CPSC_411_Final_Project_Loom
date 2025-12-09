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

// Class responsible for scheduling notifications
class NotificationManager {
    
    static func scheduleNotificaiton(userData: UserData) {
        
        // Content of the notication
        let content = UNMutableNotificationContent()
        content.title = userData.title ?? "Reminder"
        content.body = userData.body ?? "" // Reminder notes
        
        // Find the current date the notification should appear at
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userData.date ?? Date())
        
        // Find the curent time that the notification should apear at
        if let reminderTime = userData.time {
            let reminderTimeComponents = reminderTime.dateComponents
            dateComponents.hour = reminderTimeComponents.hour
            dateComponents.minute = reminderTimeComponents.minute
        }
        
        // Assign our given values from notification and send a request to the notificaiton API
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Loom Reminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
}
