//
//  Note.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 09.03.2022.
//

import Foundation

enum Note: ArticleCategory {
    case reading, song, legends, diagnostic, teamBuilding
    func description() -> String {
        switch self {
        case .reading:
            return "Чтиво"
        case .song:
            return "Песни"
        case .legends:
            return "Легенды"
        case .diagnostic:
            return "Диагностика"
        case .teamBuilding:
            return "Веревочный курс"
        }
    }
}
