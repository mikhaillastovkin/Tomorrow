//
//  TableCellImageBuilder.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 01.04.2022.
//

import Foundation
import UIKit

final class ImageBuilder {
    func imageBuild(name: String?) -> UIImage? {
        guard let name = name else {
            return UIImage(systemName: "doc.text.fill")
        }
        if let image = UIImage(systemName: name) {
            return image
        } else {
            return UIImage(named: name)
        }
    }
}
