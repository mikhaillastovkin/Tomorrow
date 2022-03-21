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
        titleLabel.numberOfLines = 1
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

    //MARK: Life circle

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
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
            image.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: Constants.offsetSuperView.x),
            image.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Constants.offsetSuperView.y / 2),

            titleLable.leftAnchor.constraint(equalTo: image.rightAnchor, constant: Constants.offsetOtherSubject.x),
            titleLable.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -Constants.offsetSuperView.x),
            titleLable.centerYAnchor.constraint(equalTo: image.centerYAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: (Constants.offsetOtherSubject.y / 6).rounded()),
            subtitleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: Constants.offsetOtherSubject.x),
            subtitleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -Constants.offsetSuperView.x)
        ])
    }

    //MARK: - Private

    private func clearCell() {
        image.image = nil
        titleLable.text = nil
        subtitleLabel.text = nil
    }

    //MARK: - Configure Cell

    func configure(image: UIImage?, title: String, subtitle: String?) {
        self.image.image = image
        self.titleLable.text = title
        self.subtitleLabel.text = subtitle
    }
}
