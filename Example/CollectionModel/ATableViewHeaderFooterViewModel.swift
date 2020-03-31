//
//  ATableViewHeaderFooterViewModel.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct ATableViewHeaderFooterViewModel {
    let title: String
}

extension ATableViewHeaderFooterViewModel: ExpressibleByStringLiteral {
    typealias StringLiteralType = String

    init(stringLiteral value: String) {
        title = value
    }
}
