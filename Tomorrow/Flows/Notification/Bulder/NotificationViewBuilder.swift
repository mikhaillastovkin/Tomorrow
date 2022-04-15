//
//  NotificationViewBuilder.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 12.04.2022.
//

import Foundation

final class NotificationViewBuilder {

    func build() -> NotificationViewController {
        let presenter = NotificationViewPresenter()
        let view = NotificationViewController(presenter: presenter)
        presenter.inputView = view
        return view
    }
}
