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

        var curentGames = [Game]()
        
        let load = LoadDataSevice()
        load.loadData { game in
            curentGames = game.sorted(by: { $0.title < $1.title })
        }

        let vc = TableViewBuilder.buildTableView(with: curentGames)
        let navController = UINavigationController(rootViewController: vc)

        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

