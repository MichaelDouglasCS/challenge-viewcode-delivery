//
//  RestaurantCellView.swift
//  DeliveryApp
//
//  Created by Michael Douglas on 22/02/22.
//

import Foundation
import UIKit

struct RestaurantCellViewModel {
    let name: String
    let detail: String
    let icon: String
}

final class RestaurantCellView: UITableViewCell {

    private struct Configurations {
        static let iconImageSize: CGSize = .init(width: 48, height: 48)
        static let contentStackViewSpacing: CGFloat = 5
    }

    // MARK: - View Properties

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Configurations.contentStackViewSpacing
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(detailLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Configurations.iconImageSize.height / 2
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Internal Methods

    func configure(with viewModel: RestaurantCellViewModel) {
        nameLabel.text = viewModel.name
        detailLabel.text = viewModel.detail
        iconImageView.image = UIImage(named: viewModel.icon)
    }

    // MARK: - Private Methods

    private func setupUI() {
        backgroundColor = .white

        setupIconImageViewConstraints()
        setupContentStackViewConstraints()
    }
}

// MARK: - Constraints

extension RestaurantCellView {

    private func setupIconImageViewConstraints() {
        contentView.addSubview(iconImageView)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            iconImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            iconImageView.heightAnchor.constraint(equalToConstant: Configurations.iconImageSize.height),
            iconImageView.widthAnchor.constraint(equalToConstant: Configurations.iconImageSize.width),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    private func setupContentStackViewConstraints() {
        contentView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            contentStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            contentStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            contentStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct RestaurantCellViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let restaurantCellView = RestaurantCellView()
            restaurantCellView.configure(
                with: .init(
                    name: "Percoriro Trattoria",
                    detail: "Italiana • 38-48 min",
                    icon: "restaurant-logo"
                )
            )

            return restaurantCellView
        }
    }
}
#endif
