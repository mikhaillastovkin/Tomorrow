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
    let props: String?
    let text: String

    enum CodingKeys: String, CodingKey {
        case title, subtitle, props, text, category
    }

    init(_ game: SimpleArticleCD) {
        self.title = game.title ?? ""
        self.category = Int(game.category)
        self.props = game.props
        self.text = game.text ?? ""
        self.imgName = ImageNameManager.getImageName(for: self.category) ?? ""
        self.subtitle = game.subtitle

    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try value.decode(String.self, forKey: .title)
        self.subtitle = try? value.decode(String.self, forKey: .subtitle)
        self.props = try? value.decode(String.self, forKey: .props)
        self.text = try value.decode(String.self, forKey: .text)
        self.category = try value.decode(Int.self, forKey: .category)
        self.imgName = ImageNameManager.getImageName(for: self.category) ?? ""
    }
}
