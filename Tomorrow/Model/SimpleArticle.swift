//
//  Article.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 09.03.2022.
//

import Foundation

struct SimpleArticle: Decodable, Article {
    
    var title: String
    var subtitle: String?
    var imgName: String
    var category: Int
    let categoryDescription: GameCategory
    let props: String?
    let text: String

    enum CodingKeys: String, CodingKey {
        case title, subtitle, props, text, category
    }

    init(_ game: GameCD) {
        self.title = game.title ?? ""
        self.subtitle = game.subtitle
        self.category = Int(game.category)
        self.props = game.props
        self.text = game.text ?? ""

        switch self.category {
        case 0:
            self.categoryDescription = GameCategory.leader
            self.imgName = "leader"
        case 1:
            self.categoryDescription = GameCategory.acquaintance
            self.imgName = "acquaintance"
        case 2:
            self.categoryDescription = GameCategory.audience
            self.imgName = "audience"
        case 3:
            self.categoryDescription = GameCategory.activity
            self.imgName = "activity"
        case 4:
            self.categoryDescription = GameCategory.mood
            self.imgName = "mood"
        case 5:
            self.categoryDescription = GameCategory.forFinish
            self.imgName = "forFinish"
        default:
            self.categoryDescription = GameCategory.leader
            self.imgName = "leader"
        }

    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try value.decode(String.self, forKey: .title)
        self.subtitle = try? value.decode(String.self, forKey: .subtitle)
        self.props = try? value.decode(String.self, forKey: .props)
        self.text = try value.decode(String.self, forKey: .text)
        self.category = try value.decode(Int.self, forKey: .category)

        switch self.category {
        case 0:
            self.categoryDescription = GameCategory.leader
            self.imgName = "leader"
        case 1:
            self.categoryDescription = GameCategory.acquaintance
            self.imgName = "acquaintance"
        case 2:
            self.categoryDescription = GameCategory.audience
            self.imgName = "audience"
        case 3:
            self.categoryDescription = GameCategory.activity
            self.imgName = "activity"
        case 4:
            self.categoryDescription = GameCategory.mood
            self.imgName = "mood"
        case 5:
            self.categoryDescription = GameCategory.forFinish
            self.imgName = "forFinish"
        default:
            self.categoryDescription = GameCategory.leader
            self.imgName = "leader"
        }
    }
}
