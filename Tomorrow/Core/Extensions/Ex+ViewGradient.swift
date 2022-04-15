//
//  Ex+ViewGradient.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 14.04.2022.
//

import UIKit

extension UIView {

    func setGreenGradient() {

        let gradient = CAGradientLayer()
        let color1 = UIColor(red: 0.25, green: 0.47, blue: 0.15, alpha: 1.00).cgColor
        let color2 = UIColor(red: 0.55, green: 0.72, blue: 0.18, alpha: 1.00).cgColor

        gradient.colors = [color1, color2]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)

        self.layer.insertSublayer(gradient, at: 0)
    }
}


