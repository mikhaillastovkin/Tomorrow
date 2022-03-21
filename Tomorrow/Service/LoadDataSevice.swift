//
//  LoadDataSevice.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 10.03.2022.
//

import Foundation

final class LoadDataSevice {

    func loadData(complition: @escaping([Game]) -> Void) {

        let path = Bundle.main.path(forResource: "games", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        guard let data = data else { return }
        let articles = try? JSONDecoder().decode([Game].self, from: data)
        complition(articles!)
        }

}
