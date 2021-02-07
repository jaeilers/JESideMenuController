//
//  MessageTableViewCell.swift
//  SideMenuControllerExample
//
//  Created by Jasmin Eilers on 15.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    private struct Constants {
        static let spacing: CGFloat = 16.0
        static let vSpacing: CGFloat = 10.0
        static let height: CGFloat = 120.0
        static let iconHeight: CGFloat = 50.0
        static let cornerRadius: CGFloat = 8.0
    }

    // MARK: - Private Properties

    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = Constants.vSpacing
        return stackView
    }()

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.vSpacing
        return stackView
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .secondarySystemFill
        imageView.layer.cornerRadius = Constants.iconHeight / 2.0
        return imageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .secondarySystemFill
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.isHidden = true
        return imageView
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Internal Methods

    func setText(_ text: String) {
        descriptionLabel.text = text
        descriptionLabel.isHidden = text.isEmpty
    }

    func showImage(_ hasImage: Bool) {
        messageImageView.isHidden = !hasImage
    }

    // MARK: - Private Methods

    private func setupView() {
        contentView.addSubview(hStackView)
        hStackView.addArrangedSubview(iconImageView)
        hStackView.addArrangedSubview(vStackView)
        vStackView.addArrangedSubview(descriptionLabel)
        vStackView.addArrangedSubview(messageImageView)

        let imageHeight = messageImageView.heightAnchor.constraint(equalToConstant: Constants.height)
        imageHeight.priority = .defaultHigh
        imageHeight.isActive = true

        NSLayoutConstraint.activate([
            hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.vSpacing),
            contentView.trailingAnchor.constraint(equalTo: hStackView.trailingAnchor, constant: Constants.spacing),
            contentView.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: Constants.spacing),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconHeight),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
            ])
    }

}
