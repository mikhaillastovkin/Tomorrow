//
//  LoadAppManager.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 11.04.2022.
//

import UIKit

final class LoadAppManager {


    func start() -> UITabBarController{

        guard let flag = UserDefaults.standard.value(forKey: "saveData") as? Bool,
              flag == true
        else {
            return firstStartApp()
        }
        return startApp()
    }

    private func firstStartApp() -> UITabBarController {

        let coreDataManager = CoreDataManager()
        let loadArticleService = LoadDataSevice<RemoteArticle>()
        let articleUrlString = "https://storage.yandexcloud.net/zavtra-v-lager/Articles.json"

        loadArticleService.fecthRemoteData(from: articleUrlString) { articles, error in
            articles?.forEach({ article in
                coreDataManager.saveRemoteArticleToCoreData(remoteArticle: article)
            })
        }

        let loadNotificationService = LoadDataSevice<Notification>()
        let notificationUrlString = "https://storage.yandexcloud.net/zavtra-v-lager/Notifications.json"

        loadNotificationService.fecthRemoteData(from: notificationUrlString) { notification, error in
            coreDataManager.saveContext()
        }

        UserDefaults.standard.set(true, forKey: "saveData")
        return start()
    }

    private func startApp() -> UITabBarController {
        let mainMenu = MainMenuBuilder().buildMainMenu()

        let favoriteArticlearticle = TableViewBuilder().buildTableView(with: .liked)

        let notificationView = NotificationViewBuilder().build()


        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .green2
        tabBarController.viewControllers = [
            prepareViewController(mainMenu, title: "Меню", systemNameImg: "house", navigation: true),
            prepareViewController(favoriteArticlearticle, title: "Избранное", systemNameImg: "heart", navigation: true),
            prepareViewController(notificationView, title: "Уведомления", systemNameImg: "bell", navigation: true)
        ]
        tabBarController.selectedIndex = 0
        tabBarController.tabBar.backgroundColor = .clear

        return tabBarController
    }

    private func prepareViewController(_ controller: UIViewController, title: String, systemNameImg: String, navigation: Bool) -> UIViewController {

        controller.title = title
        controller.tabBarItem.selectedImage = UIImage(systemName: "\(systemNameImg).fill")
        controller.tabBarItem.image = UIImage(systemName: systemNameImg)

        if navigation {
            let navigationVC = UINavigationController(rootViewController: controller)
            navigationVC.navigationBar.tintColor = .green2
            return navigationVC
        } else {
            return controller
        }
    }
}
