//
//  CategoryTableViewCell.swift
//  DeliveryApp
//
//  Created by Michael Douglas on 03/03/22.
//

import Foundation
import UIKit

final class CategoryCarouselView: UIView {

    // MARK: - View Properties

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 16, bottom: 16, right: 16)
        layout.itemSize = .init(width: 54, height: 70)
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionCellView.self, forCellWithReuseIdentifier: CategoryCollectionCellView.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    // MARK: - Private Properties

    private var categories: [Category] = []

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Internal Methods

    func configure(with categories: [Category]) {
        self.categories = categories
        collectionView.reloadData()
    }

    // MARK: - Private Methods

    private func setup() {
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension CategoryCarouselView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let categoryCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionCellView.cellIdentifier,
            for: indexPath
        ) as? CategoryCollectionCellView else {
            return .init()
        }

        let category = categories[indexPath.row]

        categoryCell.configure(with: .init(title: category.title, image: category.image))

        return categoryCell
    }
}
