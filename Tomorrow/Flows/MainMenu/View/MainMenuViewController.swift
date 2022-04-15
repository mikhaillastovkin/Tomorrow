//
//  MainMenuViewController.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 20.03.2022.
//

import UIKit

final class MainMenuViewController: UIViewController, InputMainMenu {

    //MARK: - Properties

    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    lazy private var gameLabel: UILabel = {
        let gameLabel = UILabel()
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        gameLabel.font = UIFont.maimMenuTitleLable
        gameLabel.text = "Игры"
        gameLabel.textColor = .titleColor
        return gameLabel
    }()

    lazy private var allGamesButton: UIButton = {
        let button = AllArticleMainMenuButton(color: .systemGray2)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressAllGames), for: .touchUpInside)
        return button
    }()

    lazy private var readingLabel: UILabel = {
        let readingLabel = UILabel()
        readingLabel.translatesAutoresizingMaskIntoConstraints = false
        readingLabel.font = UIFont.maimMenuTitleLable
        readingLabel.text = "Чтиво"
        readingLabel.textColor = .titleColor
        return readingLabel
    }()

    lazy private var gameCollectionView: UICollectionView = {
        let gameCollectionView = HorizontalCollectionMainMenu(backgroungColor: .systemBackground)
        gameCollectionView.dataSource = self
        gameCollectionView.delegate = self
        gameCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.cellIdentifire)
        return gameCollectionView
    }()

    lazy private var readingCollectionView: UICollectionView = {
        let readingCollectionView = HorizontalCollectionMainMenu(backgroungColor: .systemBackground)
        readingCollectionView.dataSource = self
        readingCollectionView.delegate = self
        readingCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.cellIdentifire)
        return readingCollectionView
    }()

    lazy private var otherLabel: UILabel = {
        let otherLabel = UILabel()
        otherLabel.translatesAutoresizingMaskIntoConstraints = false
        otherLabel.font = UIFont.maimMenuTitleLable
        otherLabel.text = "Пригодится"
        otherLabel.textColor = .titleColor
        otherLabel.font = UIFont.maimMenuTitleLable
        return otherLabel
    }()

    lazy private var otherCollectionView: UICollectionView = {
        let otherCollectionView = VerticalCollectionMainMenu(backgroungColor: .systemBackground)
        otherCollectionView.dataSource = self
        otherCollectionView.delegate = self
        otherCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.cellIdentifire)
        return otherCollectionView
    }()

    var presenter: OutputMainMenu

    //MARK: - Life cicle

    init(presenter: OutputMainMenu) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    //MARK: - UI

    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(gameLabel)
        self.scrollView.addSubview(allGamesButton)
        self.scrollView.addSubview(gameCollectionView)
        self.scrollView.addSubview(readingLabel)
        self.scrollView.addSubview(readingCollectionView)
        self.scrollView.addSubview(otherLabel)
        self.scrollView.addSubview(otherCollectionView)
        setupConstreints()
    }

    //MARK: - Constreints

    private func setupConstreints() {
        let safeArea = self.view.safeAreaLayoutGuide
        let scrollViewContent = scrollView.contentLayoutGuide

        let superOffsetX = Constants.offsetSuperView.x
        let superOffsetY = Constants.offsetSuperView.y
        let offsetX = Constants.offsetOtherSubject.x
        let offsetY = Constants.offsetOtherSubject.y

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            gameLabel.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: superOffsetY),
            gameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: superOffsetX),

            allGamesButton.centerYAnchor.constraint(equalTo: gameLabel.centerYAnchor),
            allGamesButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -superOffsetX),
            allGamesButton.leftAnchor.constraint(greaterThanOrEqualTo: gameLabel.rightAnchor, constant: offsetX),
            allGamesButton.heightAnchor.constraint(equalTo: gameLabel.heightAnchor),
            allGamesButton.widthAnchor.constraint(equalTo: allGamesButton.heightAnchor),

            gameCollectionView.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: offsetY),
            gameCollectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            gameCollectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            gameCollectionView.heightAnchor.constraint(equalToConstant: (view.bounds.width / 2.5)),

            readingLabel.topAnchor.constraint(equalTo: gameCollectionView.bottomAnchor, constant: offsetY),
            readingLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: superOffsetX),

            readingCollectionView.topAnchor.constraint(equalTo: readingLabel.bottomAnchor, constant: offsetY),
            readingCollectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            readingCollectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            readingCollectionView.heightAnchor.constraint(equalTo: gameCollectionView.heightAnchor),

            otherLabel.topAnchor.constraint(equalTo: readingCollectionView.bottomAnchor, constant: offsetY),
            otherLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: superOffsetX),

            otherCollectionView.topAnchor.constraint(equalTo: otherLabel.bottomAnchor, constant: offsetY),
            otherCollectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            otherCollectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            otherCollectionView.heightAnchor.constraint(equalToConstant: (view.bounds.width / 2.5) * CGFloat(presenter.items.other.count) + (offsetX * (CGFloat(presenter.items.other.count)))),
            otherCollectionView.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: -superOffsetY)
        ])
    }

    //MARK: - Navigation

    @objc private func pressAllGames() {
        presenter.pressAllGamesButton()
    }
}

//MARK: - CollectionView DataSourse

extension MainMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case gameCollectionView:
            return presenter.items.games.count
        case readingCollectionView:
            return presenter.items.reading.count
        case otherCollectionView:
            return presenter.items.other.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellIdentifire, for: indexPath) as? MainCollectionViewCell
        else { return UICollectionViewCell() }

        switch collectionView {

        case gameCollectionView:
            let item = presenter.items.games[indexPath.item]
            cell.configure(
                imageCattegory: UIImage(named: item.imageName),
                title: item.title,
                subtitle: item.subTitle,
                indexItem: indexPath.item)
            return cell

        case readingCollectionView:
            let item = presenter.items.reading[indexPath.item]
            cell.configure(
                imageBackground: UIImage(named: item.imageName),
                title: item.title,
                subtitle: item.subTitle)
            return cell

        case otherCollectionView:
            let item = presenter.items.other[indexPath.item]
            cell.configure(
                imageBackground: UIImage(named: item.imageName),
                title: item.title,
                subtitle: item.subTitle)
            return cell

        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - CollectionView Delegate

extension MainMenuViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case gameCollectionView:
            presenter.selectCategory(presenter.items.games[indexPath.row])
        case readingCollectionView:
            presenter.selectCategory(presenter.items.reading[indexPath.row])
        case otherCollectionView:
            presenter.selectCategory(presenter.items.other[indexPath.row])
        default:
            break
        }
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension MainMenuViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch collectionView {

        case gameCollectionView, readingCollectionView:
            let wight = (collectionView.bounds.width / 2.5).rounded()
            let height = collectionView.bounds.height
            return CGSize(width: wight, height: height)

        case otherCollectionView:

            let wight = (collectionView.bounds.width - Constants.offsetSuperView.x * 2)
            let height = gameCollectionView.bounds.height
            return CGSize(width: wight, height: height)

        default:
            return CGSize.zero
        }
    }
}
