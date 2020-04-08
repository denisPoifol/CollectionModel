//
//  AnimatableCollectionViewCellModel.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 08/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import DifferenceKit

struct AnimatableCollectionViewCellModel: Hashable, Differentiable {
    typealias DifferenceIdentifier = UUID

    var differenceIdentifier: UUID { id }

    let id: UUID
    let title: String
    let action: Action

    enum Action {
        case addCell
        case shuffleCells
    }
}
