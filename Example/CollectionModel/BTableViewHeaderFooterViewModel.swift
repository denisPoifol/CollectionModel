//
//  BTableViewHeaderFooterViewModel.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

struct BTableViewHeaderFooterViewModel {
    let title: String
    let backgroundColor: UIColor
}

extension BTableViewHeaderFooterViewModel: ExpressibleByStringLiteral {
    typealias StringLiteralType = String

    init(stringLiteral value: String) {
        title = value
        backgroundColor = [.red, .blue, .green].randomElement() ?? .purple
    }
}
