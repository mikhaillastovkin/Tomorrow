//
//  VerticalCollectionView.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 24.03.2022.
//

import UIKit

final class VerticalCollectionView: UICollectionView {

    convenience init(backgroungColor: UIColor) {
        let  layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        self.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = backgroungColor
        self.showsVerticalScrollIndicator = false
        self.isScrollEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

