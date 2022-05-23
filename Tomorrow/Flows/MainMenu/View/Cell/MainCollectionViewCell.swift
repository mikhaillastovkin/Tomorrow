//
//  MainCollectionViewCell.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties
    private lazy var mainImageView: UIImageView = {
        let mainImageView = UIImageView()
        mainImageView.layer.cornerRadius = Constants.corenerRadius
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.masksToBounds = true
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        return mainImageView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.mainMenuItemTitleLabel
        titleLabel.textColor = .white
        titleLabel.isHighlighted = true
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setShadow(opacity: 0.6)
        return titleLabel
    }()

    private lazy var subtitleLable: UILabel = {
        let subtitleLable = UILabel()
        subtitleLable.font = UIFont.mainMenuItemSubtitleLabel
        subtitleLable.textColor = .white
        subtitleLable.numberOfLines = 0
        subtitleLable.translatesAutoresizingMaskIntoConstraints = false
        subtitleLable.setShadow(opacity: 0.8)
        return subtitleLable
    }()

    static let cellIdentifire = "MainCollectionViewCellIdentifire"

    //MARK: - Life circle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }

    //MARK: - UI
    private func setupUI(){
        contentView.layer.masksToBounds = true
        contentView.addSubview(mainImageView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLable)
        setupConstreints()
    }

    //MARK: Constreints
    private func setupConstreints() {
        let safeArea = contentView.safeAreaLayoutGuide
        let offsetX = Constants.offsetOtherSubject.x
        let offsetY = Constants.offsetOtherSubject.y

        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainImageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            mainImageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: offsetX),
            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: offsetY),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -offsetX),
//
            subtitleLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: (offsetY / 4).rounded()),
            subtitleLable.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            subtitleLable.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),

            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -offsetX)
        ])

    }

    //MARK: - Clear reusable cell
    private func clearCell() {
        imageView.image = nil
        titleLabel.text = nil
        subtitleLable.text = nil
    }

    //MARK: - Configure Cell
    func configure(imageCattegory: UIImage?, title: String, subtitle: String, indexItem: Int) {
        self.imageView.image = imageCattegory
        self.titleLabel.text = title
        self.subtitleLable.text = subtitle

        switch indexItem {
        case 0...1:
            mainImageView.backgroundColor = .green1
        case 2...3:
            mainImageView.backgroundColor = .green2
        default:
            mainImageView.backgroundColor = .green3
        }
    }

    func configure(imageBackground: UIImage?, title: String, subtitle: String) {
        self.imageView.isHidden = true
        mainImageView.image = imageBackground
        self.titleLabel.text = title
        self.subtitleLable.text = subtitle
    }
}
