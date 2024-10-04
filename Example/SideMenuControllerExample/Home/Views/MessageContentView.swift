//
//  MessageContentView.swift
//  SideMenuControllerExample
//
//  Created by JE on 04.10.24.
//  Copyright © 2024 JE. All rights reserved.
//

import UIKit

final class MessageContentView: UIView, UIContentView {

    private struct Constants: Sendable {
        static let spacing: CGFloat = 16.0
        static let vSpacing: CGFloat = 10.0
        static let height: CGFloat = 120.0
        static let iconHeight: CGFloat = 50.0
        static let cornerRadius: CGFloat = 8.0
    }

    var configuration: any UIContentConfiguration {
        didSet {
            configure()
        }
    }

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
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.vSpacing
        return stackView
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemFill
        imageView.layer.cornerRadius = Constants.iconHeight / 2.0
        return imageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
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

    init(configuration: any UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        configuration = MessageConfiguration()
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(hStackView)
        hStackView.addArrangedSubview(iconImageView)
        hStackView.addArrangedSubview(vStackView)
        vStackView.addArrangedSubview(descriptionLabel)
        vStackView.addArrangedSubview(messageImageView)

        let imageHeight = messageImageView.heightAnchor.constraint(equalToConstant: Constants.height)
        imageHeight.priority = .defaultHigh
        imageHeight.isActive = true

        NSLayoutConstraint.activate([
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing),
            hStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.vSpacing),
            trailingAnchor.constraint(equalTo: hStackView.trailingAnchor, constant: Constants.spacing),
            bottomAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: Constants.spacing),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconHeight),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
        ])
    }

    private func configure() {
        guard let configuration = configuration as? MessageConfiguration else {
            return
        }

        descriptionLabel.text = configuration.text
        descriptionLabel.isHidden = configuration.text.isEmpty
        messageImageView.isHidden = !configuration.hasImage
    }
}
