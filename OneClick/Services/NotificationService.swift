//
//  AccessibilityService.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

import UserNotifications

class NotificationService {
    public var isPermitted: Bool = false
    
    static let shared = NotificationService()
    
    public func checkPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.isPermitted = true
                return
            }
            
            self.isPermitted = false
        }
    }
    
    func show(title: String, subtitle: String, sound: UNNotificationSound = UNNotificationSound.default, interval: Double = 0.1) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings { settings in
            guard (settings.authorizationStatus == .authorized) || (settings.authorizationStatus == .provisional) else {
                self.checkPermission()
                return
            }

            if settings.alertSetting == .enabled {
                let notification = UNMutableNotificationContent()
                
                notification.title = title
                notification.subtitle = subtitle
                notification.sound = sound
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: notification, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { (error: Error?) in
                    if let _ = error {
                        // TODO: Log error
                    }
               }
            } else {
                // TODO: Add a notification with a badge
            }
        }
    }
    
    func clear() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
