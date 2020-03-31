//
//  ACollectionViewCellModel.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct ACollectionViewCellModel {
    let title: String
}

extension ACollectionViewCellModel: ExpressibleByStringLiteral {
    typealias StringLiteralType = String

    init(stringLiteral value: String) {
        title = value
    }
}
