//
//  AricleViewController.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 09.03.2022.
//

import UIKit

final class AricleViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .title
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        return titleLabel
    }()

    private lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.font = .subTitle
        subTitleLabel.textColor = .lightGray
        return subTitleLabel

    }()

    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = .subTitle
        categoryLabel.textColor = .lightGray
        return categoryLabel
    }()

    private lazy var propsView: UIView = {
        let propsView = UIView()
        propsView.translatesAutoresizingMaskIntoConstraints = false
        propsView.layer.cornerRadius = 25
        propsView.layer.masksToBounds = true
        propsView.backgroundColor = .systemGray6
        return propsView
    }()

    private lazy var propsLabel: UILabel = {
        let propsLabel = UILabel()
        propsLabel.translatesAutoresizingMaskIntoConstraints = false
        propsLabel.font = .subTitle
        propsLabel.textColor = .lightGray
        propsLabel.text = "Понадобится:"
        return propsLabel
    }()

    private lazy var propsTextLabel: UILabel = {
        let propsTextLabel = UILabel()
        propsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        propsTextLabel.font = .subTitle
        propsTextLabel.textColor = .black
        propsTextLabel.numberOfLines = 0
        return propsTextLabel
    }()

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.font = .mainText
        textLabel.textColor = .black
        return textLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()

    }

    //MARK: - UI

    private func configureUI() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(subTitleLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(propsView)
        propsView.addSubview(propsLabel)
        propsView.addSubview(propsTextLabel)
        scrollView.addSubview(textLabel)

        configureConstraints()
    }

    private func configureConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        let scrollViewContent = scrollView.contentLayoutGuide

        let superOffsetX = Constants.offsetSuperView.x
        let superOffsetY = Constants.offsetSuperView.y
        let offsetX = Constants.offsetOtherSubject.x
        let offsetY = Constants.offsetOtherSubject.y

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            titleLabel.topAnchor.constraint(
                equalTo: scrollViewContent.topAnchor, constant: superOffsetY),
            titleLabel.leftAnchor.constraint(
                equalTo: scrollViewContent.leftAnchor, constant: superOffsetX),
            titleLabel.rightAnchor.constraint(
                equalTo: scrollViewContent.rightAnchor, constant: -superOffsetX),
            titleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - (superOffsetX + superOffsetX)),

            subTitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: (offsetY / 2).rounded()),
            subTitleLabel.leftAnchor.constraint(
                equalTo: scrollViewContent.leftAnchor, constant: superOffsetX),

            categoryLabel.leftAnchor.constraint(
                equalTo: subTitleLabel.rightAnchor, constant: offsetX),
            categoryLabel.rightAnchor.constraint(
                equalTo: scrollViewContent.rightAnchor, constant: -superOffsetX),
            categoryLabel.centerYAnchor.constraint(equalTo: subTitleLabel.centerYAnchor),

            propsView.topAnchor.constraint(
                equalTo: subTitleLabel.bottomAnchor, constant: offsetY),
            propsView.leftAnchor.constraint(
                equalTo: scrollViewContent.leftAnchor, constant: (superOffsetX / 2).rounded()),
            propsView.rightAnchor.constraint(
                equalTo: scrollViewContent.rightAnchor, constant: -(superOffsetX / 2).rounded()),

            propsLabel.topAnchor.constraint(
                equalTo: propsView.topAnchor, constant: offsetY),
            propsLabel.leftAnchor.constraint(
                equalTo: propsView.leftAnchor, constant: offsetX),
            propsLabel.rightAnchor.constraint(
                equalTo: propsView.rightAnchor, constant: -offsetX),

            propsTextLabel.topAnchor.constraint(
                equalTo: propsLabel.bottomAnchor, constant: (offsetY / 2).rounded()),
            propsTextLabel.leftAnchor.constraint(
                equalTo: propsView.leftAnchor, constant: offsetX),
            propsTextLabel.rightAnchor.constraint(
                equalTo: propsView.rightAnchor, constant: -offsetX),
            propsTextLabel.bottomAnchor.constraint(
                equalTo: propsView.bottomAnchor, constant: -offsetY),

            textLabel.topAnchor.constraint(
                equalTo: propsView.bottomAnchor, constant: offsetY),
            textLabel.leftAnchor.constraint(
                equalTo: scrollViewContent.leftAnchor, constant: superOffsetX),
            textLabel.rightAnchor.constraint(
                equalTo: scrollViewContent.rightAnchor, constant: -superOffsetX),
            textLabel.bottomAnchor.constraint(
                equalTo: scrollViewContent.bottomAnchor, constant: -superOffsetY)
        ])
    }

    //MARK: - Private

    private func checkFilledData() {

    }


}
