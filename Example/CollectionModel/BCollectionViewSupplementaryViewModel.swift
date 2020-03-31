//
//  BCollectionViewSupplementaryViewModel.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

struct BCollectionViewSupplementaryViewModel {
    let title: String
    let backgroundColor: UIColor
}

extension BCollectionViewSupplementaryViewModel: ExpressibleByStringLiteral {
    typealias StringLiteralType = String

    init(stringLiteral value: String) {
        title = value
        backgroundColor = [.red, .blue, .green].randomElement() ?? .purple
    }
}
