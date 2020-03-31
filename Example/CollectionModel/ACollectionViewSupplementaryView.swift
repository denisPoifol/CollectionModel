//
//  ACollectionViewSupplementaryView.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class ACollectionViewSupplementaryView: UICollectionReusableView {

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func configure(with viewModel: ACollectionViewSupplementaryViewModel) {
        titleLabel.text = viewModel.title
    }

    // MARK: - Private

    private func setUp() {
        let subviews: [UIView] = [
            titleLabel
        ]
        subviews.forEach(addSubview)
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.pinToSuperview(edges: [.left, .right], insets: UIEdgeInsets(horizontal: 32, vertical: 12))
        layer.borderWidth = 1
    }
}
