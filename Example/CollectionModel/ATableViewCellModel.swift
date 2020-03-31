//
//  ATableViewCellModel.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct ATableViewCellModel {
    let title: String
}

extension ATableViewCellModel: ExpressibleByStringLiteral {
    typealias StringLiteralType = String

    init(stringLiteral value: String) {
        title = value
    }
}
