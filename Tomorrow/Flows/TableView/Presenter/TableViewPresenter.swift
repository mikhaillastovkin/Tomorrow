//
//  TableViewPresenter.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 17.03.2022.
//

import UIKit

protocol InputTableView {
    var presenter: OutputTableView { get set}

}

protocol OutputTableView {
    var articles: [Article] { get set }
    var searchResult: [Article] { get set}
    func viewDidSeach(with query: String)
    func viewDidSelectArticle(index: Int)
}

final class TableViewPresenter: OutputTableView {

    var articles: [Article]
    var searchResult: [Article]

    weak var viewInput: (UIViewController & InputTableView)?

    init(articles: [Article]) {
        self.articles = articles
        self.searchResult = articles
    }

    func viewDidSeach(with query: String) {
        if query == "" {
            searchResult = articles
        } else {
            searchResult = articles.filter{ $0.title.contains(query)}
        }
    }

    func viewDidSelectArticle(index: Int) {
        if let selectGame = articles[index] as? Game {
            let vc = GameViewBuilder.buildGameViewController(with: selectGame)
            viewInput?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
