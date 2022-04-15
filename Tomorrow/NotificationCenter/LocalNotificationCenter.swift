//
//  LocalNotificationCenter.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 12.04.2022.
//

import Foundation
import UserNotifications

final class LocalNotificationCenter: NSObject {

    let notificationCenter = UNUserNotificationCenter.current()

    func requestAutorisation() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
        }
    }

    func setNotification(title: String, body: String, date: DateComponents, identifire: String) {

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.badge = 1

        let triger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let request = UNNotificationRequest(
            identifier: identifire,
            content: content,
            trigger: triger)
        notificationCenter.add(request)
    }
}

extension LocalNotificationCenter: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        completionHandler()
    }

    
}
