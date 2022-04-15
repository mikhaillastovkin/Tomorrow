//
//  CategoryDescriptionManager.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 05.04.2022.
//

import Foundation


final class CategoryManager {

    static func getSubtitle(for category: Int16) -> String {

        switch category {
        case 0:
            return "В поисках лидера"
        case 1:
            return "Для знакомства"
        case 2:
            return "Игры с залом"
        case 3:
            return "Подвижные игры"
        case 4:
            return "Для настроения"
        case 5:
            return "Игры в конце смены"
        case 6:
            return "Возрастные особенности"
        case 7:
            return "Трудные дети"
        case 8:
            return "Отрядные огоньки"
        case 9:
            return "Веревочный курс"
        case 10:
            return "Легенды лагеря"
        case 11:
            return "Спрашивали? Отвечаем!"
        case 12:
            return "Отрядный уголок"
        case 14:
            return "Песни"
        case 15:
            return "Диагностика"
        default:
            return ""
        }
    }

    static func getDiscription(for category: ArticleCategory) -> String {
        switch category {
        case .games, .leader, .acquaintance, .activity, .mood, .hallGames, .forFinish:
            return "Игры"
        case .ageFeatures, .difficultСhildren, .fireFly, .rope, .legends, .reading:
            return "Чтиво"
        case .other, .faq, .corner, .songs, .diagnostic, .crisis, .helpers:
            return "Пригодится"
        case .liked:
            return "Избранное"
        }
    }
}
