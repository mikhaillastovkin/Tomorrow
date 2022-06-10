//
//  TableViewPresenter.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 17.03.2022.
//

import UIKit
import FirebaseAnalytics

protocol InputTableView {
    var presenter: OutputTableView { get set}
}

protocol OutputTableView {
    var articles: [Article]? { get set }
    var searchResult: [Article]? { get set }
    var category: ArticleCategory { get set }
    func loadArticles(filter: ArticleCategory)
    func viewDidSeach(with query: String)
    func viewDidSelectArticle(index: Int)
}

final class TableViewPresenter: OutputTableView {
    var articles: [Article]?
    var category: ArticleCategory
    var searchResult: [Article]?
    let coredataManager: CoreDataManager
    weak var viewInput: (UIViewController & InputTableView)?

    init(articleCategory: ArticleCategory, coredataManager: CoreDataManager) {
        self.coredataManager = coredataManager
        category = articleCategory
    }

    func loadArticles(filter: ArticleCategory) {
        articles = coredataManager.loadArticles(filter: filter)?
            .sorted(by: <)
        searchResult = articles
    }

    //MARK: - Search article
    func viewDidSeach(with query: String) {
        if query == "" {
            searchResult = articles
        } else {
            searchResult = articles?.filter{
                guard let title = $0.title
                else { return false }
                return title.lowercased().contains(query.lowercased()) }
        }
    }

    //MARK: - Select article
    func viewDidSelectArticle(index: Int) {
        guard let selectArticle = searchResult?[index]
        else { return }
        let vc = ArticleViewBuilder().buildArticleViewController(with: selectArticle)
        viewInput?.navigationController?.pushViewController(vc, animated: true)
        Analytics.logEvent("selectArticle", parameters: ["name" : selectArticle.title as Any])
    }
}
