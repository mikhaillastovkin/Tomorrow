//
//  MainMenuBuilder.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

final class MainMenuBuilder{

    private func fillData() -> (games: [MainMenuItem], reading: [MainMenuItem], other: [MainMenuItem]) {
        return (fillGames(), fillReading(), fillOther())
    }

    private func fillGames() -> [MainMenuItem] {
        var games: [MainMenuItem] = []

        games.append(MainMenuItem(
            title: "В поисках лидера",
            subTitle: "Организационный \nпериод",
            imageName: "leader",
            articleCategory: .leader))
        games.append(MainMenuItem(
            title: "Для знакомства",
            subTitle: "Организационный \nпериод",
            imageName: "acquaintance",
            articleCategory: .acquaintance))
        games.append(MainMenuItem(
            title: "Подвижные игры",
            subTitle: "Основной \nпериод",
            imageName: "activity",
            articleCategory: .activity))
        games.append(MainMenuItem(
            title: "Для настроения",
            subTitle: "Основной \nпериод",
            imageName: "mood",
            articleCategory: .mood))
        games.append(MainMenuItem(
            title: "Игры с залом",
            subTitle: "Основной \nпериод",
            imageName: "audience",
            articleCategory: .hallGames))
        games.append(MainMenuItem(
            title: "В конце смены",
            subTitle: "Заключительный \nпериод",
            imageName: "forFinish",
            articleCategory: .forFinish))
        return games
    }

    private func fillReading() -> [MainMenuItem] {
        var reading: [MainMenuItem] = []

        reading.append(MainMenuItem(
            title: "Возрастные особенности",
            subTitle: "Проблемы и решения",
            imageName: "children",
            articleCategory: .ageFeatures))
        reading.append(MainMenuItem(
            title: "Трудные дети",
            subTitle: "Как быть?",
            imageName: "badBoy",
            articleCategory: .difficultСhildren))
        reading.append(MainMenuItem(
            title: "Отрядные огоньки",
            subTitle: "А поговорить?",
            imageName: "candles",
            articleCategory: .fireFly))
        reading.append(MainMenuItem(
            title: "Веревочный курс",
            subTitle: "Связанные \nодной целью",
            imageName: "rope",
            articleCategory: .rope))
        reading.append(MainMenuItem(
            title: "Легенды лагеря",
            subTitle: "Давным-давно…",
            imageName: "legends",
            articleCategory: .legends))

        return reading
    }

    private func fillOther() -> [MainMenuItem] {
        var other: [MainMenuItem] = []

        other.append(MainMenuItem(
            title: "Твои помощники",
            subTitle: "Как найти союзников?",
            imageName: "helper",
            articleCategory: .helpers))
        other.append(MainMenuItem(
            title: "Если нужен результат?",
            subTitle: "Диагностика и опросы",
            imageName: "diagnostic",
            articleCategory: .diagnostic))
        other.append(MainMenuItem(
            title: "Отрядный уголок",
            subTitle: "Рисуем, вырезаем, клеим...",
            imageName: "art",
            articleCategory: .corner))
        other.append(MainMenuItem(
            title: "А есть гитара?",
            subTitle: "Тексты и аккорды самых любимых лагерных песен",
            imageName: "songs",
            articleCategory: .songs))
        other.append(MainMenuItem(
            title: "Кризисы",
            subTitle: "Сложные ситуации и пути решения",
            imageName: "crisis",
            articleCategory: .crisis))
        other.append(MainMenuItem(
            title: "Спрашивали? Отвечаем!",
            subTitle: "Ответы на популярные вопросы",
            imageName: "faq",
            articleCategory: .faq))

        return other
    }

    func buildMainMenu() -> (UIViewController & InputMainMenu) {
        let items = fillData()
        let presenter = MainMenuPresenter(items: items)
        let vc = MainMenuViewController(presenter: presenter)
        presenter.viewInput = vc
        return vc
    }
}
