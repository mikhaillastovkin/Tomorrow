//
//  NotificationViewPresenter.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 12.04.2022.
//

import Foundation
import UIKit

protocol InputNotificationViewController {
    var presenter: OutputNotificationViewController { get set }
    var date: Date? { get set }
    var daysCount: Int? { get set }
    func setOKButton(title: String, isEnable: Bool)
    func presentAlert(title: String, message: String?)
}

protocol OutputNotificationViewController {
    func setNotification()
    func cancelNotification()
    func requestAutorisation()
}

final class NotificationViewPresenter: OutputNotificationViewController {

    weak var inputView: (UIViewController & InputNotificationViewController)? {
        didSet {
            checkNotification()
        }
    }

    private let notificationCenter = LocalNotificationCenter()
    private let coreDataManager = CoreDataManager()

    lazy private var dataFormater: DateFormatter = {
        let dataFormater = DateFormatter()
        dataFormater.dateStyle = .medium
        dataFormater.locale = Locale(identifier: "ru_RU")
        dataFormater.timeStyle = .none
        return dataFormater
    }()

    private func checkNotification() {
        guard let startDate = UserDefaults.standard.value(forKey: UDKeyNotification.dateStart.rawValue) as? Date,
              let daysCount = UserDefaults.standard.value(forKey: UDKeyNotification.daysCount.rawValue) as? Int
        else {
            inputView?.setOKButton(title: "Установить", isEnable: true)
            return
        }
        let titleButton = "Дата начала: \(dataFormater.string(from: startDate)) \nПролдолжительность \(daysCount) дней"
        inputView?.setOKButton(title: titleButton, isEnable: false)
    }

    func requestAutorisation() {
        notificationCenter.requestAutorisation()
    }


    func cancelNotification() {
        notificationCenter.notificationCenter.removeAllPendingNotificationRequests()
        UIApplication.shared.applicationIconBadgeNumber = 0
        UserDefaults.standard.removeObject(forKey: UDKeyNotification.daysCount.rawValue)
        UserDefaults.standard.removeObject(forKey: UDKeyNotification.dateStart.rawValue)
        checkNotification()
    }

    func setNotification() {

        guard let startDate = inputView?.date,
              let daysCount = inputView?.daysCount
        else { return }

        let allNotifications = coreDataManager.loadNotification()

        DispatchQueue.global().async { [weak self] in
            let filterNotification = allNotifications?
                .filter({ $0.offsetTime < daysCount - 2 })
            let penultimateDay = allNotifications?.filter({ $0.identifire == "Предпоследний день"}).first
            let lastDay = allNotifications?.filter({ $0.identifire == "Последний день"}).first

            filterNotification?.forEach({
                guard let date = Calendar.current.date(byAdding: .day, value: Int($0.offsetTime), to: startDate)
                else { return }
                let dateComponent = date.getDateComponenet()
                self?.notificationCenter.setNotification(title: $0.title, body: $0.body, date: dateComponent, identifire: $0.identifire)
                })

            guard let penultimateDate = Calendar.current.date(byAdding: .day, value: daysCount - 2, to: startDate)
            else { return }
            self?.notificationCenter.setNotification(
                title: penultimateDay?.title,
                body: penultimateDay?.body,
                date: penultimateDate.getDateComponenet(),
                identifire: penultimateDay?.identifire)

            guard let lastDate = Calendar.current.date(byAdding: .day, value: daysCount - 1, to: startDate)
            else { return }
            self?.notificationCenter.setNotification(
                title: lastDay?.title,
                body: lastDay?.body,
                date: lastDate.getDateComponenet(),
                identifire: lastDay?.identifire)

            UserDefaults.standard.setValuesForKeys([
                UDKeyNotification.dateStart.rawValue : startDate,
                UDKeyNotification.daysCount.rawValue : daysCount
            ])
            DispatchQueue.main.async { [weak self] in
                self?.checkNotification()
                self?.inputView?.presentAlert(title: "Уведомления установлены", message: nil)
            }
        }
    }
}
