//
//  AnimatableTableViewCell.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 07/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class AnimatableTableViewCell: UITableViewCell {

    private let titleLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    func configure(with viewModel: AnimatableTableViewCellModel) {
        titleLabel.text = viewModel.title
    }

    // MARK: - Private

    private func setUp() {
        let subviews: [UIView] = [
            titleLabel
        ]
        subviews.forEach(contentView.addSubview)
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        titleLabel.pinToSuperview(insets: UIEdgeInsets(horizontal: 32, vertical: 12))
    }
}
