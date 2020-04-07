//
//  AnimatableTableViewCellModel.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 07/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct AnimatableTableViewCellModel {
    let title: String
    let action: Action

    enum Action {
        case addCell
        case shuffleCells
    }
}
