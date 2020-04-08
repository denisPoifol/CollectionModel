//
//  BCollectionViewCell.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class BCollectionViewCell: UICollectionViewCell {

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func configure(with viewModel: BCollectionViewCellModel) {
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.textColor
        layer.borderColor = viewModel.textColor.cgColor
    }

    // MARK: - Private

    private func setUp() {
        let subviews: [UIView] = [
            titleLabel
        ]
        subviews.forEach(contentView.addSubview)
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        titleLabel.pinToSuperview(insets: UIEdgeInsets(horizontal: 16, vertical: 12), priority: .applyIfPossible)
        titleLabel.numberOfLines = 0
        layer.borderWidth = 1
    }
}
