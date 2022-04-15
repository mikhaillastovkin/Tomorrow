//
//  RemoteArticle.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 08.04.2022.
//

import Foundation

struct RemoteArticle: Decodable{

    let title: String?
    let subtitle: String?
    let category: Int
    let text: String?
    let imgName: String?
    let props: String?
    let url: String?
}
