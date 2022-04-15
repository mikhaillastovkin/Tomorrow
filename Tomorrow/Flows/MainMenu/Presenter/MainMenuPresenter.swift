//
//  MainMenuPresenter.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit
import CoreData

protocol InputMainMenu {
    var presenter: OutputMainMenu { get set }
}

protocol OutputMainMenu {
    var items: (games: [MainMenuItem], reading: [MainMenuItem], other: [MainMenuItem]) {get set}
    func selectCategory(_ item: MainMenuItem)
    func pressAllGamesButton()
}

final class MainMenuPresenter: OutputMainMenu {

    var items: (games: [MainMenuItem], reading: [MainMenuItem], other: [MainMenuItem])
    weak var viewInput: (UIViewController & InputMainMenu)?
    let coreDataManager = CoreDataManager()

    init(items: (games: [MainMenuItem], reading: [MainMenuItem], other: [MainMenuItem])) {
        self.items.games = items.games
        self.items.reading = items.reading
        self.items.other = items.other
    }

    //MARK: Present

    private func presentArticles(category: ArticleCategory) {
        let coredataManager = CoreDataManager()
        let articles = coredataManager.loadArticles(filter: category)
        if articles?.count == 1,
           let article = articles?.first {
            let vc = ArticleViewBuilder().buildArticleViewController(with: article)
            viewInput?.navigationController?.pushViewController(vc, animated: true)
        } else {
            let tableView = TableViewBuilder().buildTableView(with: category)
            tableView.title = CategoryManager.getDiscription(for: category)
            viewInput?.navigationController?.pushViewController(tableView, animated: true)
        }
    }

    //MARK: Navigation

    func selectCategory(_ item: MainMenuItem) {
        presentArticles(category: item.articleCategory)
    }

    func pressAllGamesButton() {
        presentArticles(category: .games)
    }
}
