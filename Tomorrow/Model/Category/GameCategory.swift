//
//  GameCategory.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 09.03.2022.
//

import Foundation

enum GameCategory {

    case leader, acquaintance, audience, activity, mood, forFinish

    func description() -> String {
        switch self {
        case .leader:
            return "В поисках лидера"
        case .acquaintance:
            return "Для знакомства"
        case .audience:
            return "Игры с залом"
        case .activity:
            return "Подвижные игры"
        case .mood:
            return "Для настроения"
        case .forFinish:
            return "Игры в конце смены"
        }
    }

    func addSubTitle() -> String {
        switch self {
        case .leader, .acquaintance:
            return "Организационный период"
        case .audience, .activity, .mood:
            return "Основной период"
        case .forFinish:
            return "Заключительный период"
        }
    }
}
