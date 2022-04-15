//
//  AllArticleMainMenuButton.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

class AllArticleMainMenuButton: UIButton {

    convenience init(color: UIColor) {
        self.init(type: .custom)
        self.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        self.tintColor = color
        self.scalesLargeContentImage = true
    }
}
