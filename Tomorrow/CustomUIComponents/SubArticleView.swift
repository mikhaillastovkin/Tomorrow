//
//  SubArticleView.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 06.04.2022.
//

import UIKit

class SubArticleView: UIView {
    
    convenience init(backgroundColor: UIColor) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = Constants.corenerRadius
        self.layer.masksToBounds = true
        self.backgroundColor = backgroundColor
    }
}
