//
//  Game.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 09.03.2022.
//

import Foundation

enum Game: ArticleCategory {
    case leader, acquaintance, audience, activity, mood, forFinish

    func description() -> String {
        switch self {
        case .leader:
            return "В поисках лидера"
        case .acquaintance:
            return "Для знакомство"
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
}
