//
//  LocalNotificationCenter.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 12.04.2022.
//

import UserNotifications
import UIKit

enum UDKeyNotification: String {
    case setNotification
    case dateStart
    case daysCount
}

final class LocalNotificationCenter: NSObject {

    let notificationCenter = UNUserNotificationCenter.current()

    func requestAutorisation() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
        }
    }

    func setNotification(title: String?, body: String?, date: DateComponents?, identifire: String?) {

        guard let title = title,
              let body = body,
              let identifire = identifire,
              let date = date
        else { return }

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.userInfo = ["TYPE" : identifire]

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
        if let scene = (response.targetScene as? UIWindowScene),
           let tabBar = scene.windows.first?.rootViewController as? UITabBarController,
           let navigationController = tabBar.selectedViewController as? UINavigationController {
            let identifire = response.notification.request.identifier
            let coreDataManager = CoreDataManager()
            guard let article = coreDataManager.loadArticles(filter: .crisis)?
                .filter({ $0.title == identifire })
                .first
            else { return }
            let viewController = ArticleViewBuilder().buildArticleViewController(with: article)
            navigationController.pushViewController(viewController, animated: true)
        }
        completionHandler()
    }
}
