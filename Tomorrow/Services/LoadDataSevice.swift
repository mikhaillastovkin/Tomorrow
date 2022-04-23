//
//  LoadDataSevice.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 10.03.2022.
//

import UIKit
import CoreData

final class LoadDataSevice<T: Decodable> {

    func loadRemoteData(from: String, complition: @escaping(Data?, LoadDataError?) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: from)
        else {
            complition(nil, .wrongUrl )
            return }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode < 400,
                  error == nil
            else {
                complition(nil, .networkError)
                return
            }
            DispatchQueue.main.async {
                complition(data, nil)
            }
        }
        task.resume()
    }

    func fecthRemoteData(from: String, complition: @escaping([T]?, LoadDataError?) -> Void) {
        loadRemoteData(from: from) { data, error in
            guard let data = data
            else {
                complition(nil, error)
                return
            }
            let dispatchGroup = DispatchGroup()
            var array: [T]?
            var currentError: LoadDataError?

            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager().getContext()

            DispatchQueue.global().async(group: dispatchGroup) {
                do {
                    array = try decoder.decode([T].self, from: data)
                }
                catch {
                    currentError = .wrongPars
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main) {
                complition(array, currentError)
            }
        }
    }
}

