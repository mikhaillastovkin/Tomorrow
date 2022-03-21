//
//  MainCollectionViewCell.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 21.03.2022.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties

    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Constants.corenerRadius
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.mainMenuItemTitleLabel
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 3
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    lazy private var subtitleLable: UILabel = {
        let subtitleLable = UILabel()
        subtitleLable.font = UIFont.mainMenuItemSubtitleLabel
        subtitleLable.textColor = .white
        subtitleLable.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLable
    }()

    static let cellIdentifire = "MainCollectionViewCellIdentifire"

    //MARK: - Life circle

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }

    //MARK: - UI
    private func setupUI(){
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
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: offsetX),
            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: offsetY),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -offsetX),

            subtitleLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: (offsetY / 4).rounded()),
            subtitleLable.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            subtitleLable.rightAnchor.constraint(equalTo: titleLabel.rightAnchor)
        ])
    }

    //MARK: - Private

    private func clearCell() {
        imageView.image = nil
        titleLabel.text = nil
        subtitleLable.text = nil
    }

    //MARK: - Configure Cell

    func configure(image: UIImage?, title: String, subtitle: String) {
        setupUI()
        self.imageView.image = image
        self.titleLabel.text = title
        self.subtitleLable.text = subtitle
    }
}
