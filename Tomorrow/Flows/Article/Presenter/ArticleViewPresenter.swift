//
//  GameViewPresenter.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 10.03.2022.
//

import Foundation
import UIKit

protocol InputArticleViewController {
    var presenter: OutputArticleViewController { get set}
    func fillData()

}

protocol OutputArticleViewController {
    var article: Article { get set }

}

final class ArticleViewPresenter: OutputArticleViewController {
    
    var article: Article
    weak var inputView: (UIViewController & InputArticleViewController)?

    init(artikle: Article) {
        self.article = artikle
    }

}
