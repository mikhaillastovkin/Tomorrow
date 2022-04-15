//
//  Shadows.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 22.03.2022.
//

import Foundation
import UIKit

extension UILabel {

    func setShadow(opacity: Float) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = 5
    }
}
