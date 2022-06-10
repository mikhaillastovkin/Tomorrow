//
//  MainMenuPresenter.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit
import CoreData
import FirebaseAnalytics

protocol InputMainMenu {
    var presenter: OutputMainMenu { get set }
    func presentError(message: String)
}

protocol OutputMainMenu {
    var items: (games: [MainMenuItem], reading: [MainMenuItem], other: [MainMenuItem]) {get set}
    func selectCategory(_ item: MainMenuItem)
    func pressAllGamesButton()
    func checkError()
    func reloadData()
}

final class MainMenuPresenter: OutputMainMenu {
    weak var viewInput: (UIViewController & InputMainMenu)?
    var items: (games: [MainMenuItem], reading: [MainMenuItem], other: [MainMenuItem])
    var loadDataError: LoadDataError?
    let coreDataManager: AbstractCoreDataManager

    init(items: (games: [MainMenuItem], reading: [MainMenuItem], other: [MainMenuItem]), coreDataManager: AbstractCoreDataManager) {
        self.items.games = items.games
        self.items.reading = items.reading
        self.items.other = items.other
        self.coreDataManager = coreDataManager
        checkData()
    }

    //MARK: Present
    private func presentArticles(category: ArticleCategory) {
        let coredataManager = CoreDataManager()
        let articles = coredataManager.loadArticles(filter: category)
        if articles?.count == 1,
           let article = articles?.first {
            let vc = ArticleViewBuilder().buildArticleViewController(with: article)
            viewInput?.navigationController?.pushViewController(vc, animated: true)
        } else {
            let tableView = TableViewBuilder().buildTableView(with: category)
            tableView.title = CategoryManager.getDiscription(for: category)
            viewInput?.navigationController?.pushViewController(tableView, animated: true)
        }
    }

    //MARK: Navigation
    func selectCategory(_ item: MainMenuItem) {
        presentArticles(category: item.articleCategory)
        Analytics.logEvent("selectCategory", parameters: [AnalyticsParameterContent : item.title])
    }

    func pressAllGamesButton() {
        presentArticles(category: .games)
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [AnalyticsParameterValue : "pressAllGamesButton"])
    }

    //MARK: LoadData
    private func checkData() {
        guard let flagData = UserDefaults.standard.value(forKey: "saveData") as? Bool,
              let flagNotification = UserDefaults.standard.value(forKey: "saveNotification") as? Bool,
              flagData == true,
              flagNotification == true
        else {
            loadData()
            return
        }
    }

    private func loadData() {
            loadArticle()
            loadNotification()
    }

    private func loadArticle() {
        let loadArticleService = LoadDataSevice<RemoteArticle>()
        let articleUrlString = "https://storage.yandexcloud.net/zavtra-v-lager/Articles.json"

        loadArticleService.fecthRemoteData(from: articleUrlString) { [weak self] articles, error in
            guard error != nil,
                  let error = error
            else {
                articles?.forEach({ article in
                    self?.coreDataManager.saveRemoteArticleToCoreData(remoteArticle: article)
                })
                UserDefaults.standard.set(true, forKey: "saveData")
                self?.loadDataError = nil
                return
            }
            self?.loadDataError = error
        }
    }

    private func loadNotification() {
        let loadNotificationService = LoadDataSevice<Notification>()
        let notificationUrlString = "https://storage.yandexcloud.net/zavtra-v-lager/Notifications.json"

        loadNotificationService.fecthRemoteData(from: notificationUrlString) { [weak self] _, error in
            guard error != nil,
                  let error = error
            else {
                self?.coreDataManager.saveContext()
                UserDefaults.standard.set(true, forKey: "saveNotification")
                self?.loadDataError = nil
                return
            }
            self?.loadDataError = error
        }
    }

    //MARK: Error

    func checkError() {
        if loadDataError != nil {
            presentError(error: loadDataError)
        }
    }

    func reloadData() {
        checkData()
        checkError()
    }

    private func presentError(error: LoadDataError?) {
        guard let error = error else {
            return
        }
        switch error {
        case .wrongUrl:
            viewInput?.presentError(message: "С сервером что-то не так! Уже работаем над этим!")
        case .networkError:
            viewInput?.presentError(message: "Необходимо загрузить базу данных. Повторите попытку когда будет устойчивый сигнал.")
        case .wrongPars:
            viewInput?.presentError(message: "С сервером что-то не так! Уже работаем над этим!")
        }
    }
}
