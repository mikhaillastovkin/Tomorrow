//
//  Notification+CoreDataClass.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 13.04.2022.
//
//

import Foundation
import CoreData

@objc(Notification)
public class Notification: NSManagedObject, Decodable {

    enum CodingKeys: CodingKey {
        case title, offsetTime, identifire, body
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)

        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try? value.decode(String.self, forKey: .title)
        self.body = try? value.decode(String.self, forKey: .body)
        self.offsetTime = try value.decode(Int16.self, forKey: .offsetTime)
        self.identifire = try? value.decode(String.self, forKey: .identifire)
    }
}
