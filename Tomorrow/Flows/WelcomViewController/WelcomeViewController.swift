//
//  WelcomeViewController.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 21.04.2022.
//

import UIKit
import AudioToolbox

final class WelcomeViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: contentInset, left: 0, bottom: contentInset, right: 0)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.offsetOtherSubject.y
        stackView.alignment = .trailing
        stackView.distribution = .fill
        return stackView
    }()

    private let contentInset = Constants.offsetSuperView.y * 4

    let messageArray = [
        ("Если ты это читаешь, значит в твоей жизни скоро появится много детей. На несколько дней, а может и недель ты станешь для них самым близким человеком - вожатым!", 0),
        ("Мы сами долгое время осваивали эту профессию и очень и ее полюбили.", 5),
        ("В этом приложении собраны подсказки, как провести лагерную смену без проблем. Основная часть - это игры!", 3),
        ("Все материалы будут доступны даже в лесу. \nОднако, при первом запуске интернет все же понадобится.", 3),
        ("Статьи и игры, которые понравятся, можно сохранить в избранное. Для этого просто нажми на 💚", 5),
        ("Кроме того, ты можешь получать уведомления о возможных кризисах во время смены.", 5),
        ("Удачи и надеемся, что тебе понравится!", 3)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentMessages()
    }

    private func setupUI() {
        view.setGreenGradient()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        setConstraints()
    }

    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let offset = Constants.offsetSuperView

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: offset.x),
            stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -offset.x),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0)
        ])
    }

    private func presentMessages() {
        var timeoffset = DispatchTime.now()
        for message in messageArray {
            timeoffset = timeoffset.advanced(by: DispatchTimeInterval.seconds(message.1))
            DispatchQueue.main.asyncAfter(deadline: timeoffset) { [weak self] in
                self?.addMessage(message: message.0)
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                self?.checkHeightScrollContent()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: timeoffset + 3) { [weak self] in
            guard let self = self
            else { return }
            self.addStartButton()
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
            self.checkHeightScrollContent()
        }
    }

    private func checkHeightScrollContent() {
        view.layoutIfNeeded()
        let stacViewHeight = stackView.frame.height
        let scrollViewHeight = scrollView.frame.height
        if stacViewHeight + contentInset > scrollViewHeight {
            scrollView.setContentOffset(
                CGPoint(
                    x: 0,
                    y: stacViewHeight + contentInset - scrollViewHeight),
                animated: true)
        }
    }

    private func addMessage(message: String) {
        let messageView = SubArticleView(backgroundColor: .white)
        messageView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = message
        label.numberOfLines = 0
        label.font = .mainText
        label.textColor = .green3
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false

        messageView.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        messageView.alpha = 0

        messageView.addSubview(label)
        stackView.addArrangedSubview(messageView)

        NSLayoutConstraint.activate([
            messageView.leftAnchor.constraint(greaterThanOrEqualTo: stackView.leftAnchor, constant: (stackView.frame.width / 5).rounded()),
            label.topAnchor.constraint(equalTo: messageView.topAnchor, constant: Constants.offsetOtherSubject.y),
            label.leftAnchor.constraint(greaterThanOrEqualTo: messageView.leftAnchor, constant: Constants.offsetOtherSubject.x),
            label.rightAnchor.constraint(equalTo: messageView.rightAnchor, constant: -Constants.offsetOtherSubject.x),
            label.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -Constants.offsetOtherSubject.y)
        ])

        UIView.animate(withDuration: 0.5) {
            messageView.transform = .identity
            messageView.alpha = 1
        }
    }

    private func addStartButton() {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Начнём?", for: .normal)
        button.titleLabel?.font = .mainMenuItemTitleLabel
        button.setImage(UIImage(systemName: "leaf.fill"), for: .normal)
        button.tintColor = .green3
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addTarget(
            self,
            action: #selector(closeView),
            for: .touchUpInside)

        stackView.addArrangedSubview(button)

        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: Constants.offsetOtherSubject.x),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])

        button.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        button.alpha = 0

        UIView.animate(withDuration: 0.5) {
            button.transform = .identity
            button.alpha = 1
        }
    }

    @objc private func closeView() {
        UserDefaults.standard.set(Date(), forKey: "firstStart")
        let mainMenu = TabBarBuilder().build()
        mainMenu.modalPresentationStyle = .fullScreen
        present(mainMenu, animated: true, completion: nil)
    }
}
