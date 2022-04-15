//
//  GameViewBuilder.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

final class ArticleViewBuilder {

    func buildArticleViewController(with article: Article) -> (ArticleViewController) {
        let presenter = ArticleViewPresenter(artikle: article)
        let viewController = ArticleViewController(presenter: presenter)
        presenter.inputView = viewController
        return viewController
    }
}
