//
//  Article+CoreDataClass.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 08.04.2022.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject {

}

extension Article: Comparable {
    public static func < (lhs: Article, rhs: Article) -> Bool {

        guard let left = lhs.title,
              let right = rhs.title
        else { return false }

        let lPrefix = String(left.prefix(2)).trimmingCharacters(in: .init(charactersIn: " "))
        let rRrefix = String(right.prefix(2)).trimmingCharacters(in: .init(charactersIn: " "))

        if let lInt = Int(lPrefix),
           let rInt = Int(rRrefix) {
            return lInt < rInt
        } else {
            return left < right
        }
    }
}
