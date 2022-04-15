//
//  HorizontalCollectionMainMenu.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

final class HorizontalCollectionMainMenu: UICollectionView {

    convenience init(backgroungColor: UIColor) {
        let  layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: Constants.offsetSuperView.x, bottom: 0, right: Constants.offsetSuperView.x)
        layout.minimumLineSpacing = Constants.offsetOtherSubject.x

        self.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = backgroungColor
        self.showsHorizontalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
