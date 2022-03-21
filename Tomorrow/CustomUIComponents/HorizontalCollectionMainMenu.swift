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
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        self.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = backgroungColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
