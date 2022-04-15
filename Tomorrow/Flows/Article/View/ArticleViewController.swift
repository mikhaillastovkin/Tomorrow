//
//  AricleViewController.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 09.03.2022.
//

import UIKit

class ArticleViewController: UIViewController, InputArticleViewController {

    //MARK: - Properties

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .title
        titleLabel.numberOfLines = 0
        titleLabel.layer.masksToBounds = false
        return titleLabel
    }()

    lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.font = .subTitle
        subTitleLabel.numberOfLines = 1
        return subTitleLabel
    }()

    private lazy var propsView: UIView = {
        let propsView = UIView()
        propsView.translatesAutoresizingMaskIntoConstraints = false
        propsView.layer.cornerRadius = 25
        propsView.layer.masksToBounds = true
        propsView.backgroundColor = .systemGray4
        return propsView
    }()

    private lazy var propsLabel: UILabel = {
        let propsLabel = UILabel()
        propsLabel.translatesAutoresizingMaskIntoConstraints = false
        propsLabel.font = .subTitle
        propsLabel.text = "Понадобится:"
        return propsLabel
    }()

    private lazy var propsTextLabel: UILabel = {
        let propsTextLabel = UILabel()
        propsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        propsTextLabel.font = .titleTabelViewCell
        propsTextLabel.numberOfLines = 0
        return propsTextLabel
    }()

    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = .mainText
        textLabel.numberOfLines = 0
        return textLabel
    }()

    var presenter: OutputArticleViewController

    //MARK: - LifeCicle

    init(presenter: OutputArticleViewController) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillData()
    }

    //MARK: - UI

    private func configureUI() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(subTitleLabel)
        scrollView.addSubview(propsView)
        propsView.addSubview(propsLabel)
        propsView.addSubview(propsTextLabel)
        scrollView.addSubview(textLabel)

        configureConstraints()
    }

    //MARK: - Constreints

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
                equalTo: safeArea.leftAnchor, constant: superOffsetX),
            titleLabel.rightAnchor.constraint(
                equalTo: safeArea.rightAnchor, constant: -superOffsetX),

            subTitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: (offsetY / 2).rounded()),
            subTitleLabel.leftAnchor.constraint(
                equalTo: safeArea.leftAnchor, constant: superOffsetX),

            propsView.topAnchor.constraint(
                equalTo: subTitleLabel.bottomAnchor, constant: offsetY),
            propsView.leftAnchor.constraint(
                equalTo: safeArea.leftAnchor, constant: (superOffsetX / 2).rounded()),
            propsView.rightAnchor.constraint(
                equalTo: safeArea.rightAnchor, constant: -(superOffsetX / 2).rounded()),

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
                equalTo: safeArea.leftAnchor, constant: superOffsetX),
            textLabel.rightAnchor.constraint(
                equalTo: safeArea.rightAnchor, constant: -superOffsetX),
            textLabel.bottomAnchor.constraint(
                equalTo: scrollViewContent.bottomAnchor, constant: -superOffsetY)
        ])
    }

    //MARK: - Private

    private func hidePropsView() {
        propsLabel.removeFromSuperview()
        propsTextLabel.removeFromSuperview()
        propsView.removeFromSuperview()

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: Constants.offsetOtherSubject.y)
        ])
    }

    //MARK: - Fill data

    func fillData() {
        if let game = presenter.article as? SimpleArticle {
            titleLabel.text = game.title
            textLabel.text = game.text

            if game.subtitle == nil {
                subTitleLabel.text = CategoryManager.getSubtitle(for: game)
            } else {
                subTitleLabel.text = game.subtitle
            }

            if game.props == nil {
                hidePropsView()
            } else {
                propsTextLabel.text = game.props
            }
        }

//        if let paper = presenter.article as? Paper {
//            hidePropsView()
//            titleLabel.text = paper.title
//            subTitleLabel.text = paper.subtitle
//
//            let path = Bundle.main.path(forResource: paper.fileName, ofType: "html")
//            let url = URL(fileURLWithPath: path!)
//
//            guard let htmlData = try? NSString(contentsOf: url, usedEncoding: nil).data(using: String.Encoding.utf8.rawValue),
//                  let attribute = try? NSMutableAttributedString(data: htmlData, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
//
//            else { return }
//
//            textLabel.attributedText = attribute
//            textLabel.textColor = .textColor
//        }

//        if let other = presenter.article as? Other {
//            titleLabel.text = other.title
//            textLabel.text = other.text
//            hidePropsView()
//        }
    }
}

