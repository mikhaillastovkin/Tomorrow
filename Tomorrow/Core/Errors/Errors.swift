//
//  Errors.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 28.03.2022.
//

import Foundation


enum ParsDataError: Error {
    case notFoundData, wrongType
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

enum LoadDataError: Error {
    case wrongUrl, networkError
}
