//
//  ArticleProtocol.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 17.03.2022.
//

import Foundation

protocol Article{
    var title: String { get set }
    var subtitle: String? { get set }
    var imgName: String { get set }
    var category: Int { get set }
}
