//
//  Note.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 28.03.2022.
//

import Foundation

struct Note: Decodable, Article {
    var title: String
    var subtitle: String?
    var imageName: String


}
