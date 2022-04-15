//
//  LoadDataSevice.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 10.03.2022.
//

import UIKit
import CoreData

final class LoadDataSevice<T: Decodable> {

    func loadRemoteData(from: String, complition: @escaping(Data?, Error?) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: from)
        else {
            complition(nil, LoadDataError.wrongUrl )
            return }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode < 400,
                  error == nil
            else {
                complition(nil, LoadDataError.networkError)
                return
            }
            DispatchQueue.main.async {
                complition(data, nil)
            }
        }
        task.resume()
    }

    func fecthRemoteData(from: String, complition: @escaping([T]?, Error?) -> Void) {
        loadRemoteData(from: from) { data, error in
            guard let data = data
            else {
                complition(nil, error)
                return
            }

            let dispatchGroup = DispatchGroup()

            var array: [T]?
            var error: Error?

            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager().getContext()

            DispatchQueue.global().async(group: dispatchGroup) {
                do {
                    array = try decoder.decode([T].self, from: data)
                }
                catch let currentError as NSError {
                    print(currentError.localizedDescription)
                    error = currentError
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main) {
                complition(array, error)
            }
        }
    }
}

