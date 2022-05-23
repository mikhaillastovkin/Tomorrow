//
//  Colors.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

extension UIColor {

    static let titleColor = UIColor { trait -> UIColor in
        if trait.userInterfaceStyle == .dark {
            return UIColor.white
        } else {
            return UIColor(red: 0.00, green: 0.33, blue: 0.06, alpha: 1.00)
        }
    }

    static let textColor = UIColor { trait -> UIColor in
        if trait.userInterfaceStyle == .dark {
            return UIColor.white
        } else {
            return UIColor.black
        }
    }

    static let green1 = UIColor(red: 0.56, green: 0.73, blue: 0.00, alpha: 1.00)
    static let green2 = UIColor(red: 0.39, green: 0.51, blue: 0.00, alpha: 1.00)
    static let green3 = UIColor(red: 0.29, green: 0.38, blue: 0.00, alpha: 1.00)
}
