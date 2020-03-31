//
//  BCollectionViewCellModel.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

struct BCollectionViewCellModel {
    let title: String
    let textColor: UIColor
}

extension BCollectionViewCellModel: ExpressibleByStringLiteral {
    typealias StringLiteralType = String

    init(stringLiteral value: String) {
        title = value
        textColor = [.red, .blue, .green].randomElement() ?? .purple
    }
}
