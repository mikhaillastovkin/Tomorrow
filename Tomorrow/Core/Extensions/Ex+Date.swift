//
//  Ex+Date.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 13.04.2022.
//

import Foundation

extension Date {
    func getDateComponenet() -> DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute,. second], from: self)
    }
}
