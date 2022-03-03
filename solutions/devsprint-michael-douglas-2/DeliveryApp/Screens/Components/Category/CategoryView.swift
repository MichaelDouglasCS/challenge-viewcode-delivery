//
//  CategoryCellView.swift
//  DeliveryApp
//
//  Created by Murillo R. Araújo on 21/02/22.
//

import UIKit

final class CategoryView: UIView {

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    public init() {
        super.init(frame: .zero)

        addSubviews()
        setConstraints()
        setStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        imageView.image = UIImage(named: viewModel.image)
    }

    private func addSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }

    private func setConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate ([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 54),
            imageView.heightAnchor.constraint(equalToConstant: 54),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setStyle() {
        backgroundColor = .white
    }
}

extension CategoryView {

    struct ViewModel {
        var title: String
        var image: String
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CategoryCellViewViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let categoryCell = CategoryView()
            categoryCell.configure(with: .init(title: "Pizza", image: "pizza"))
            return categoryCell
        }
        .previewLayout(.fixed(width: 100, height: 100))
    }
}
#endif
