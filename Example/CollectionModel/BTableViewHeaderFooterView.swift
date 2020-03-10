//
//  BTableViewHeaderFooterView.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class BTableViewHeaderFooterView: UITableViewHeaderFooterView {

    private let titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    func configure(with viewModel: BTableViewHeaderFooterViewModel) {
        titleLabel.text = viewModel.title
        contentView.backgroundColor = viewModel.backgroundColor
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
