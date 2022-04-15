//
//  Other.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 31.03.2022.
//

import Foundation
import UIKit

struct Other: Decodable, Article {

    var title: String
    var subtitle: String?
    var imgName: String
    let text: String
    var category: Int

    enum CodingKeys: String, CodingKey {
        case title, subtitle, text, category
    }

    init(_ other: OtherCD) {
        self.title = other.title ?? ""
        self.text = other.text ?? ""
        self.imgName = "questionmark.square.fill"
        self.category = 10

    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try value.decode(String.self, forKey: .title)
        self.text = try value.decode(String.self, forKey: .text)
        self.imgName = "questionmark.square.fill"
        self.category = 10
    }
}

