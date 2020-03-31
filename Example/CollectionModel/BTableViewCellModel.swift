//
//  BTableViewCellModel.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

struct BTableViewCellModel {
    let title: String
    let textColor: UIColor
}

extension BTableViewCellModel: ExpressibleByStringLiteral {
    typealias StringLiteralType = String

    init(stringLiteral value: String) {
        title = value
        textColor = [.red, .blue, .green].randomElement() ?? .purple
    }
}
