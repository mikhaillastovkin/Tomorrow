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

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .title
        titleLabel.numberOfLines = 0
        titleLabel.layer.masksToBounds = false
        return titleLabel
    }()

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = .green1
        return image
    }()

    private lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.font = .subTitle
        subTitleLabel.numberOfLines = 1
        return subTitleLabel
    }()

    private lazy var propsView: UIView = {
        let propsView = SubArticleView(backgroundColor: .green3)
        return propsView
    }()

    private lazy var propsLabel: UILabel = {
        let propsLabel = UILabel()
        propsLabel.translatesAutoresizingMaskIntoConstraints = false
        propsLabel.font = .subTitle
        propsLabel.text = "Понадобится:"
        propsLabel.textColor = .white
        return propsLabel
    }()

    private lazy var propsTextLabel: UILabel = {
        let propsTextLabel = UILabel()
        propsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        propsTextLabel.font = .titleTabelViewCell
        propsTextLabel.numberOfLines = 0
        propsTextLabel.textColor = .white
        return propsTextLabel
    }()

    private lazy var textLabel: UILabel = {
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
        configureUI()
    }

    //MARK: - Private

    //MARK: UI

    private func configureUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .systemBackground
        self.view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(subTitleLabel)
        scrollView.addSubview(propsView)
        propsView.addSubview(propsLabel)
        propsView.addSubview(propsTextLabel)
        scrollView.addSubview(textLabel)
        configureConstraints()
    }

    //MARK: Constreints

    private func configureConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        let scrollViewContent = scrollView.contentLayoutGuide
        let superOffsetX = Constants.offsetSuperView.x
        let offsetX = Constants.offsetOtherSubject.x
        let offsetY = Constants.offsetOtherSubject.y

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            titleLabel.topAnchor.constraint(
                equalTo: scrollViewContent.topAnchor, constant: offsetY),
            titleLabel.leftAnchor.constraint(
                equalTo: safeArea.leftAnchor, constant: superOffsetX),
            titleLabel.rightAnchor.constraint(equalTo: imageView.leftAnchor, constant: -offsetX),

            imageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            imageView.rightAnchor.constraint(
                equalTo: safeArea.rightAnchor, constant: -superOffsetX),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),

            subTitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: (offsetY / 2).rounded()),
            subTitleLabel.leftAnchor.constraint(
                equalTo: safeArea.leftAnchor, constant: superOffsetX),

            textLabel.leftAnchor.constraint(
                equalTo: safeArea.leftAnchor, constant: superOffsetX),
            textLabel.rightAnchor.constraint(
                equalTo: safeArea.rightAnchor, constant: -superOffsetX),
            textLabel.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: -offsetY)
        ])

        if !propsView.isHidden {
            NSLayoutConstraint.activate([
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
            ])
        } else {
            NSLayoutConstraint.activate([
                textLabel.topAnchor.constraint(
                    equalTo: subTitleLabel.bottomAnchor, constant: offsetY)
            ])
        }
    }

    func setLikeButton(isLiked: Bool) {
        let img: String
        if isLiked {
            img = "suit.heart.fill"
        } else {
            img = "suit.heart"
        }
        let likeItem = UIBarButtonItem(
            image: UIImage(systemName: img),
            style: .plain,
            target: self,
            action: #selector(pressLikeButton))

        navigationController?.navigationBar.contentMode = .right

        self.navigationItem.rightBarButtonItems =  [likeItem]
    }

    @objc private func pressLikeButton() {
        presenter.pressLikeButton()
    }

    //MARK: Hide props

    private func hidePropsView() {
        propsView.isHidden = true
    }

    //MARK: - Fill data

    func fillDataArticle(title: String?, image: UIImage?, subtitle: String?, attributeText: NSAttributedString?, props: String?) {

        titleLabel.text = title
        imageView.image = image
        subTitleLabel.text = subtitle
        textLabel.attributedText = attributeText
        textLabel.textColor = .textColor
        guard let props = props else {
            hidePropsView()
            return
        }
        propsTextLabel.text = props
    }
}
