//
//  CategoryCarouselCellView.swift
//  DeliveryApp
//
//  Created by Michael Douglas on 03/03/22.
//

import Foundation
import UIKit

final class CategoryCarouselCellView: UITableViewCell {

    struct Configurations {
        static let carouselHeight: CGFloat = 100.0
    }

    // MARK: - View Properties

    private lazy var categoryCarousel: CategoryCarouselView = {
        let view = CategoryCarouselView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Internal Methods

    func configure(with viewModel: ViewModel) {
        categoryCarousel.configure(with: viewModel.categories)
    }

    // MARK: - Private Methods

    private func setup() {
        contentView.backgroundColor = .lightGray
        contentView.addSubview(categoryCarousel)

        NSLayoutConstraint.activate([
            categoryCarousel.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryCarousel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryCarousel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCarousel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            categoryCarousel.heightAnchor.constraint(equalToConstant: Configurations.carouselHeight)
        ])
    }
}

extension CategoryCarouselCellView {

    struct ViewModel {
        var categories: [Category]
    }
}

struct Category {
    var title: String
    var image: String
}
