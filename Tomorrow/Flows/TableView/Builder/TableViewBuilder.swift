//
//  TableViewBuilder.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

final class TableViewBuilder {

    func buildTableView(with category: ArticleCategory) -> (TableViewController) {
        let presenter = TableViewPresenter(articleCategory: category, coredataManager: CoreDataManager())
        let viewController = TableViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
