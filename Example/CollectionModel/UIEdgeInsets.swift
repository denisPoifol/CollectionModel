//
//  UIEdgeInsets.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 28/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    init(horizontal: CGFloat, vertical: CGFloat) {
        left = horizontal
        right = horizontal
        top = vertical
        bottom = vertical
    }

    init(value: CGFloat) {
        left = value
        right = value
        top = value
        bottom = value
    }
}
