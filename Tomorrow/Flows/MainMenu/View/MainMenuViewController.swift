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
        return scrollView
    }()

    lazy private var gameLabel: UILabel = {
        let gameLabel = UILabel()
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        gameLabel.font = UIFont.maimMenuTitleLable
        gameLabel.text = "ИГРЫ"
        return gameLabel
    }()

    lazy private var allGamesButton: UIButton = {
        let button = AllArticleMainMenuButton(color: .systemGray2)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy private var readingLabel: UILabel = {
        let readingLabel = UILabel()
        readingLabel.translatesAutoresizingMaskIntoConstraints = false
        readingLabel.font = UIFont.maimMenuTitleLable
        readingLabel.text = "ЧТИВО"
        return readingLabel
    }()

    lazy private var allReadingButton: UIButton = {
        let button = AllArticleMainMenuButton(color: .systemGray2)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy private var gameCollectionView: UICollectionView = {
        let gameCollectionView = HorizontalCollectionMainMenu(backgroungColor: .systemBackground)
        return gameCollectionView
    }()

    lazy private var readingCollectionView: UICollectionView = {
        let readingCollectionView = HorizontalCollectionMainMenu(backgroungColor: .green)
        return readingCollectionView
    }()

    var presenter: OutputMainMenu

    //MARK: - Life circle

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
        setupGamesCollectionView()
    }

    //MARK: - UI

    private func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(gameLabel)
        self.scrollView.addSubview(allGamesButton)
        self.scrollView.addSubview(gameCollectionView)
        self.scrollView.addSubview(readingLabel)
        self.scrollView.addSubview(allReadingButton)
        self.scrollView.addSubview(readingCollectionView)
        self.view.backgroundColor = .systemBackground
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
            gameLabel.leftAnchor.constraint(equalTo: scrollViewContent.leftAnchor, constant: superOffsetX),

            allGamesButton.centerYAnchor.constraint(equalTo: gameLabel.centerYAnchor),
            allGamesButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -superOffsetX),
            allGamesButton.leftAnchor.constraint(greaterThanOrEqualTo: gameLabel.rightAnchor, constant: offsetX),
            allGamesButton.heightAnchor.constraint(equalTo: gameLabel.heightAnchor),

            gameCollectionView.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: offsetY),
            gameCollectionView.leftAnchor.constraint(equalTo: scrollViewContent.leftAnchor, constant: 0),
            gameCollectionView.rightAnchor.constraint(equalTo: scrollViewContent.rightAnchor, constant: 0),
            gameCollectionView.heightAnchor.constraint(equalToConstant: (safeArea.layoutFrame.height / 5).rounded()),
            gameCollectionView.widthAnchor.constraint(equalToConstant: view.bounds.width),

            readingLabel.topAnchor.constraint(equalTo: gameCollectionView.bottomAnchor, constant: offsetY),
            readingLabel.leftAnchor.constraint(equalTo: scrollViewContent.leftAnchor, constant: superOffsetX),

            allReadingButton.centerYAnchor.constraint(equalTo: readingLabel.centerYAnchor),
            allReadingButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -superOffsetX),
            allReadingButton.leftAnchor.constraint(greaterThanOrEqualTo: readingLabel.rightAnchor, constant: offsetX),
            allReadingButton.heightAnchor.constraint(equalTo: readingLabel.heightAnchor),


            readingCollectionView.topAnchor.constraint(equalTo: readingLabel.bottomAnchor, constant: offsetY),
            readingCollectionView.leftAnchor.constraint(equalTo: scrollViewContent.leftAnchor, constant: 0),
            readingCollectionView.rightAnchor.constraint(equalTo: scrollViewContent.rightAnchor, constant: 0),
            readingCollectionView.heightAnchor.constraint(equalTo: gameCollectionView.heightAnchor),
            readingCollectionView.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: -superOffsetY)
        ])
    }

    //MARK: - Private

    private func setupGamesCollectionView() {
        gameCollectionView.dataSource = self
        gameCollectionView.delegate = self
        gameCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.cellIdentifire)
    }
}

//MARK: - CollectionView DataSourse

extension MainMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case gameCollectionView:
            return presenter.items.games.count
        case readingCollectionView:
            return presenter.items.reading?.count ?? 0
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {

        case gameCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellIdentifire, for: indexPath) as? MainCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            let item = presenter.items.games[indexPath.row]

            
            cell.configure(
                image: UIImage(named: item.imageName),
                title: item.title,
                subtitle: item.title)
            return cell

        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - CollectionView DataSourse
extension MainMenuViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

}


