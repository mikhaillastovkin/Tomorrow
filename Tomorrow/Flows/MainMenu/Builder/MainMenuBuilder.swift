//
//  MainMenuBuilder.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

final class MainMenuBuilder{

    private func fillData() -> (games: [MainMenuItem], reading: [MainMenuItem]?, other: [MainMenuItem]?) {
        return (fillGames(), fillReading(), fillOther())
    }

    private func fillGames() -> [MainMenuItem] {
        var games: [MainMenuItem] = []

        games.append(MainMenuItem(
            title: "В поисках лидера",
            subTitle: "Организационный период",
            imageName: "leader"))
        games.append(MainMenuItem(
            title: "Для знакомства",
            subTitle: "Организационный период",
            imageName: "acquaintance"))
        games.append(MainMenuItem(
            title: "Подвижные игры",
            subTitle: "Основной период",
            imageName: "activity"))
        games.append(MainMenuItem(
            title: "Для настроения",
            subTitle: "Основной период",
            imageName: "mood"))
        games.append(MainMenuItem(
            title: "Игры с залом",
            subTitle: "Основной период",
            imageName: "audience"))
        games.append(MainMenuItem(
            title: "В конце смены",
            subTitle: "Заключительны период",
            imageName: "forFinish"))
        return games
    }

    private func fillReading() -> [MainMenuItem]? {
        return nil
    }

    private func fillOther() -> [MainMenuItem]? {
        return nil
    }

    func buildMainMenu() -> (UIViewController & InputMainMenu) {
        let items = fillData()
        let presenter = MainMenuPresenter(items: items)
        let vc = MainMenuViewController(presenter: presenter)
        presenter.viewInput = vc
        return vc
    }
}
