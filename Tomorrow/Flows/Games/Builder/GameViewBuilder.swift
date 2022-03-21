//
//  GameViewBuilder.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

final class GameViewBuilder {

    static func buildGameViewController(with game: Game) -> (UIViewController & InputGameViewController) {
        let presenter = GameViewPresenter(artikle: game)
        let viewController = GamesViewController(presenter: presenter)
        presenter.inputView = viewController
        return viewController
    }
}
