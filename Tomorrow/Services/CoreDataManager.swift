//
//  CoreDataManager.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 08.04.2022.
//

import CoreData
import UIKit

protocol AbstractCoreDataManager {
    func saveContext()
    func saveRemoteArticleToCoreData(remoteArticle: RemoteArticle)
    func loadArticles(filter: ArticleCategory) -> [Article]?
    func loadNotification() -> [Notification]?
}

final class CoreDataManager: AbstractCoreDataManager {

    //MARK: - Public
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func saveContext() {
        do {
            try getContext().save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func saveRemoteArticleToCoreData(remoteArticle: RemoteArticle) {
        let context = getContext()
        let article = Article(context: context)
        article.title = remoteArticle.title
        article.subtitle = remoteArticle.subtitle
        article.category = Int16(remoteArticle.category)
        article.text = remoteArticle.text
        article.props = remoteArticle.props
        article.imgName = remoteArticle.imgName
        article.isLiked = false
        article.sortTag = remoteArticle.sortTag

        guard let urlString = remoteArticle.url else {
            article.htmlData = nil
            saveContext()
            return
        }
        let loadDataServise = LoadDataSevice<RemoteArticle>()
        loadDataServise.loadRemoteData(from: urlString) { data, _ in
            article.htmlData = data
            self.saveContext()
        }
    }

    func loadArticles(filter: ArticleCategory) -> [Article]? {
        var resultArray: [Article]? = []

        switch filter {
        case .games :
            for category in ArticleCategory.leader.rawValue...ArticleCategory.forFinish.rawValue {
                resultArray?.append(contentsOf: getFilterArrayForCategory(category) ?? [])
            }
        case .liked:
            resultArray?.append(contentsOf: getFilterArrayForLiked() ?? [])
        default:
            resultArray?.append(contentsOf: getFilterArrayForCategory(filter.rawValue) ?? [])
        }
        return resultArray
    }

    func loadNotification() -> [Notification]? {
        let feachReuest = Notification.fetchRequest()
        do {
            let array = try getContext().fetch(feachReuest)
            return array
        } catch let error as NSError {
            print(error)
            return []
        }
    }

    func changeArtikleIsLike(article: Article)  {
        article.setValue(!article.isLiked, forKey: "isLiked")
        saveContext()
    }

    //MARK: - Private
    private func getFilterArrayForCategory(_ category: Int16) -> [Article]? {
        let fetchRequest = Article.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %i", category)
        do {
            let array = try getContext().fetch(fetchRequest)
            return array
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }

    private func getFilterArrayForLiked() -> [Article]? {
        let fetchRequest = Article.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isLiked == %d", true)
        do {
            let array = try getContext().fetch(fetchRequest)
            return array
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
}
