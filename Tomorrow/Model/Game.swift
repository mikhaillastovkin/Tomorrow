//
//  Article.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 09.03.2022.
//

import Foundation

struct Game: Decodable, Article {
    
    var title: String
    var subtitle: String?
    var imageName: String
    let category: Int
    let categoryDescription: GameCategory
    let props: String?
    let text: String

    enum CodingKeys: String, CodingKey {
        case title, subtitle, props, text, category
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
            self.imageName = "leader"
        case 1:
            self.categoryDescription = GameCategory.acquaintance
            self.imageName = "acquaintance"
        case 2:
            self.categoryDescription = GameCategory.audience
            self.imageName = "audience"
        case 3:
            self.categoryDescription = GameCategory.activity
            self.imageName = "activity"
        case 4:
            self.categoryDescription = GameCategory.mood
            self.imageName = "mood"
        case 5:
            self.categoryDescription = GameCategory.forFinish
            self.imageName = "forFinish"
        default:
            self.categoryDescription = GameCategory.leader
            self.imageName = "leader"
        }
    }
}
