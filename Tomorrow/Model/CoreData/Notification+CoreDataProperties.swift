//
//  Notification+CoreDataProperties.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 13.04.2022.
//
//

import Foundation
import CoreData

extension Notification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notification> {
        return NSFetchRequest<Notification>(entityName: "Notification")
    }

    @NSManaged public var body: String?
    @NSManaged public var identifire: String?
    @NSManaged public var offsetTime: Int16
    @NSManaged public var title: String?
}

extension Notification : Identifiable {

}
