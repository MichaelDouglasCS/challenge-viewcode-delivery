//
//  CategoryCollectionCellView.swift
//  DeliveryApp
//
//  Created by Michael Douglas on 03/03/22.
//

import Foundation
import UIKit

final class CategoryCollectionCellView: UICollectionViewCell {

    // MARK: - View Properties

    private lazy var categoryView: CategoryView = {
        let view = CategoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Internal Methods

    func configure(with viewModel: CategoryView.ViewModel) {
        categoryView.configure(with: viewModel)
    }

    // MARK: - Private Methods

    private func setup() {
        contentView.addSubview(categoryView)

        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CategoryCollectionCellViewViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let categoryCell = CategoryCollectionCellView()
            categoryCell.configure(with: .init(title: "Pizza", image: "pizza"))
            return categoryCell
        }
        .previewLayout(.fixed(width: 100, height: 100))
    }
}
#endif
