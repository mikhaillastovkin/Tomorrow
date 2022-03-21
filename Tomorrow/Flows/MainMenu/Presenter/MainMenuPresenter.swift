//
//  MainMenuPresenter.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import Foundation
import UIKit

protocol InputMainMenu {
    var presenter: OutputMainMenu { get set}

}

protocol OutputMainMenu {
    var items: (games: [MainMenuItem], reading: [MainMenuItem]?, other: [MainMenuItem]?) {get set}

}

final class MainMenuPresenter: OutputMainMenu {

    var items: (games: [MainMenuItem], reading: [MainMenuItem]?, other: [MainMenuItem]?)

    weak var viewInput: (UIViewController & InputMainMenu)?

    init(items: (games: [MainMenuItem], reading: [MainMenuItem]?, other: [MainMenuItem]?)) {
        self.items.games = items.games
        self.items.reading = items.reading
        self.items.other = items.other
    }

    
}
