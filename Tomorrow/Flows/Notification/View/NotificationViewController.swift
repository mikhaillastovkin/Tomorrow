//
//  NotificationViewController.swift
//  Завтра в лагерь
//
//  Created by Михаил Ластовкин on 12.04.2022.
//

import UIKit

enum NotificationViewButton {
    case okButton, cancelButton
}

final class NotificationViewController: UIViewController, InputNotificationViewController {

    //MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calend")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var textView: UIView = {
        let textView = SubArticleView(backgroundColor: .green3)
        return textView
    }()

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .mainText
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.text = """
        Вы можете получать подсказки в кризисные дни лагерной смены.

        Для этого установите:
        дату начала смены, время получения уведомлений и количество дней смены.
        """
        textLabel.textColor = .white
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    private lazy var datePicer: UIDatePicker = {
        let datePicer = UIDatePicker()
        datePicer.datePickerMode = .dateAndTime
        datePicer.timeZone = TimeZone.current
        datePicer.preferredDatePickerStyle = .compact
        datePicer.minuteInterval = 30
        datePicer.contentHorizontalAlignment = .fill
        datePicer.contentVerticalAlignment = .fill
        datePicer.translatesAutoresizingMaskIntoConstraints = false
        return datePicer
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Количество дней смены"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var okButton: UIButton = {
        let actionButton = UIButton(type: .system)
        actionButton.tintColor = .white
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(pressOKButton), for: .touchUpInside)
        actionButton.layer.cornerRadius = Constants.corenerRadius
        actionButton.layer.masksToBounds = true
        return actionButton
    }()

    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Отменить уведомления", for: .normal)
        cancelButton.tintColor = .gray
        cancelButton.backgroundColor = .systemBackground
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(pressCancelButton), for: .touchUpInside)
        return cancelButton
    }()

    var presenter: OutputNotificationViewController
    var date: Date?
    var daysCount: Int?

    //MARK: - Life cicle
    init(presenter: OutputNotificationViewController) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        presenter.requestAutorisation()
    }

    //MARK: - UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(textView)
        textView.addSubview(textLabel)
        scrollView.addSubview(datePicer)
        scrollView.addSubview(textField)
        scrollView.addSubview(okButton)
        scrollView.addSubview(cancelButton)
        setConstreints()
    }

    private func setConstreints() {
        let safeArea = view.safeAreaLayoutGuide
        let superOffsetY = Constants.offsetSuperView.y * 2
        let superOffsetX = Constants.offsetSuperView.x
        let offsetX = Constants.offsetOtherSubject.x
        let offsetY = Constants.offsetOtherSubject.y
        let scrollContent = scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: (view.bounds.width / 4).rounded()),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.topAnchor.constraint(equalTo: scrollContent.topAnchor, constant: offsetY),

            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: offsetY),
            textView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: (superOffsetX / 2).rounded()),
            textView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -(superOffsetX / 2).rounded()),

            textLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: offsetY),
            textLabel.leftAnchor.constraint(equalTo: textView.leftAnchor, constant: offsetX),
            textLabel.rightAnchor.constraint(equalTo: textView.rightAnchor, constant: -offsetX),
            textLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -offsetY),

            datePicer.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: superOffsetY),
            datePicer.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),

            textField.topAnchor.constraint(equalTo: datePicer.bottomAnchor, constant: offsetX),
            textField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: superOffsetX),
            textField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -superOffsetX),

            okButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: superOffsetY),
            okButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            okButton.widthAnchor.constraint(equalToConstant: (view.bounds.width / 1.5).rounded()),
            okButton.heightAnchor.constraint(equalToConstant: 60),

            cancelButton.topAnchor.constraint(equalTo: okButton.bottomAnchor, constant: offsetX),
            cancelButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor, constant: -superOffsetY)
        ])
    }

    //MARK: - Action
    @objc private func pressOKButton() {
        date = datePicer.date
        if let count = textField.text,
           count != ""{
            daysCount = Int(count)
            presenter.setNotification()
        } else {
            presentAlert(title: "Ошибка", message: "Не указано количество дней")
        }
    }

    @objc private func pressCancelButton() {
        let alert = UIAlertController(
            title: "Удалить все уведомления?",
            message: nil,
            preferredStyle: .actionSheet)
        let doneAction = UIAlertAction(title: "Продолжить", style: .destructive) { [weak self] _ in
            self?.presenter.cancelNotification()
            self?.textField.text = ""
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

        alert.addAction(doneAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    func setOKButton(title: String, isEnable: Bool) {
        okButton.setTitle(title, for: .normal)
        okButton.isEnabled = isEnable
        if isEnable {
            okButton.backgroundColor = .green3
        } else {
            okButton.backgroundColor = .lightGray
        }
    }

    //MARK: - Alert
    func presentAlert(title: String, message: String?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let alertAction = UIAlertAction(
            title: "ОК", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}

//MARK: - TextField Delegate
extension NotificationViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.scrollView.contentInset = UIEdgeInsets(top: -200, left: 0, bottom: 250, right: 0)
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(textFieldEndEditing))
        view.addGestureRecognizer(tapGestureRecognizer)
        return true
    }

    @objc private func textFieldEndEditing() {
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.scrollView.contentInset = UIEdgeInsets.zero
            self.textField.resignFirstResponder()
        }
    }
}
