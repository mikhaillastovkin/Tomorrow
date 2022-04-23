//
//  TabBarBuilder.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 11.04.2022.
//

import UIKit

final class TabBarBuilder {

    func build() -> UITabBarController {
        let mainMenu = MainMenuBuilder().buildMainMenu()
        let favoriteArticlearticle = TableViewBuilder().buildTableView(with: .liked)
        let notificationView = NotificationViewBuilder().build()

        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.tintColor = .green2
        tabBarController.viewControllers = [
            prepareViewController(mainMenu, title: "Меню", systemNameImg: "leaf", navigation: true),
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
