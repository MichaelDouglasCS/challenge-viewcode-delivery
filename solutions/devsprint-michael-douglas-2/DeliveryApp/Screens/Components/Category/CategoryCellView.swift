//
//  CategoryCellView.swift
//  DeliveryApp
//
//  Created by Murillo R. Araújo on 21/02/22.
//

import UIKit

final class CategoryCellView: UIView {

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pizza")
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pizza"
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

    func setStyle() {
        backgroundColor = .white
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CategoryCellViewPreviews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let categoryCellView = CategoryCellView()

            return categoryCellView
        }
        .previewLayout(.fixed(width: 70, height: 95))
    }
}
#endif
