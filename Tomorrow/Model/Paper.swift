//
//  Paper.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 28.03.2022.
//

import Foundation

struct Paper: Decodable, Article {

    var category: Int
    var title: String
    var subtitle: String?
    var imgName: String
    var fileName: String

    enum CodingKeys: String, CodingKey {
        case title, subtitle, imageName, fileName
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try value.decode(String.self, forKey: .title)
        self.subtitle = try? value.decode(String.self, forKey: .subtitle)
        self.imgName = try value.decode(String.self, forKey: .imageName)
        self.fileName = try value.decode(String.self, forKey: .fileName)
        self.category = 11
    }

    init(_ paper: PaperCD) {
        self.title = paper.title ?? ""
        self.subtitle = paper.subtitle
        self.imgName = paper.imageName ?? ""
        self.fileName = paper.fileName ?? ""
        self.category = 11
    }
}
