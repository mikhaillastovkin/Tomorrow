//
//  GameViewPresenter.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 10.03.2022.
//

import Foundation
import UIKit

protocol InputGameViewController {
    var presenter: OutputGameViewController { get set}
    func fillData()

}

protocol OutputGameViewController {
    var article: Game { get set }

}

final class GameViewPresenter: OutputGameViewController {

    var article: Game
    weak var inputView: (UIViewController & InputGameViewController)?

    init(artikle: Game) {
        self.article = artikle
    }

}
