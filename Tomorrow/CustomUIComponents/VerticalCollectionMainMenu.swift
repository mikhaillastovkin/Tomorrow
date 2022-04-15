//
//  VerticalCollectionMainMenu.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 24.03.2022.
//

import UIKit

final class VerticalCollectionMainMenu: UICollectionView {

    convenience init(backgroungColor: UIColor) {
        let  layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: Constants.offsetSuperView.x, bottom: 0, right: Constants.offsetSuperView.x)
        layout.minimumLineSpacing = Constants.offsetOtherSubject.x

        self.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = backgroungColor
        self.showsVerticalScrollIndicator = false
        self.isScrollEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

