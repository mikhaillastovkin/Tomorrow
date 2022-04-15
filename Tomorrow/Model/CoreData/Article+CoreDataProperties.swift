//
//  Article+CoreDataProperties.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 08.04.2022.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var category: Int16
    @NSManaged public var imgName: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var props: String?
    @NSManaged public var htmlData: Data?

}

extension Article : Identifiable {

}
