//
//  TableViewCell.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 17.03.2022.
//

import UIKit

final class TableViewCell: UITableViewCell {

    //MARK: - Properties

    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy private var titleLable: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 3
        titleLabel.font = UIFont.titleTabelViewCell
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    lazy private var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = UIFont.subtitleTabelViewCell
        subtitleLabel.textColor = .systemGray2
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()

    static let cellIdentifire = "TableViewCell"

    //MARK: Life cicle
    
    override func layoutSubviews () {
        super.layoutSubviews()
        configureUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }

    //MARK: - UI

    private func configureUI() {
        contentView.addSubview(image)
        contentView.addSubview(titleLable)
        contentView.addSubview(subtitleLabel)
        setupConstrains()
    }

    private func setupConstrains() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 60),
            image.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constants.offsetSuperView.y / 2),
            image.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: Constants.offsetOtherSubject.x),
            image.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Constants.offsetSuperView.y / 2),

            titleLable.leftAnchor.constraint(equalTo: image.rightAnchor, constant: Constants.offsetOtherSubject.x),
            titleLable.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -Constants.offsetSuperView.x),
            titleLable.centerYAnchor.constraint(equalTo: image.centerYAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: (Constants.offsetOtherSubject.y / 6).rounded()),
            subtitleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: Constants.offsetOtherSubject.x),
            subtitleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -Constants.offsetSuperView.x)
        ])
    }

    //MARK: - Clear cell before reuse

    private func clearCell() {
        image.image = nil
        titleLable.text = nil
        subtitleLabel.text = nil
    }

    //MARK: - Configure Cell

    func configure(image: String?, title: String?, subtitle: String?, indexPath: IndexPath) {
        let imageBuilder = ImageBuilder()
        self.image.image = imageBuilder.imageBuild(name: image)
        self.titleLable.text = title
        self.subtitleLabel.text = subtitle

        if indexPath.row % 2 == 0 {
            self.image.tintColor = UIColor.green1
        } else {
            self.image.tintColor = UIColor.green2
        }
    }
}
