//
//  NotificationsHelper.swift
//  PixelYear
//
//  Created by Елизавета on 01.10.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation
import UserNotifications


class NotificationsHelper: NSObject, UNUserNotificationCenterDelegate {
    let notificationCenter = UNUserNotificationCenter.current()

    override init() {
        super.init()
        notificationCenter.delegate = self
    }

    func userRequest() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]

        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }

    func scheduleNotification() {
        let userActions = "User Actions"
        let identifier = "Local Notification"
        var dateComponents = DateComponents()
        dateComponents.hour = 21
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let content = configureNotification(userActions: userActions)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        addNotificationActions(userActions: userActions)
    }

    func configureNotification(userActions: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "How was your day?"
        content.body = "Mark while the memories are fresh"
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userActions
        return content
    }

    func addNotificationActions(userActions: String) {
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: userActions,
            actions: [snoozeAction, deleteAction],
            intentIdentifiers: [],
            options: [])

        notificationCenter.setNotificationCategories([category])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {

        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }

        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
            scheduleNotification()
        case "Delete":
            print("Delete")
        default:
            print("Unknown action")
        }
        completionHandler()
    }
}
