//
//  TableViewBuilder.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

final class TableViewBuilder {

    static func buildTableView(with articles: [Article]) -> (UIViewController & InputTableView) {
        let presenter = TableViewPresenter(articles: articles)
        let viewController = TableViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
