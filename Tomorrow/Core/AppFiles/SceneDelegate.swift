//
//  SceneDelegate.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 09.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)

        UIApplication.shared.applicationIconBadgeNumber = 0

        guard let _ = UserDefaults.standard.value(forKey: "firstStart")
        else {
            let welcome = WelcomeViewController()
            window?.rootViewController = welcome
            window?.makeKeyAndVisible()
            return
        }

        let tabBarController = TabBarBuilder().build()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

