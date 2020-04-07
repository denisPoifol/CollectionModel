//
//  TableViewModel+DifferenceKit.swift
//  CollectionModelAnimation
//
//  Created by Denis Poifol on 07/04/2020.
//

import Foundation
import CollectionModelCore
import DifferenceKit

extension TableViewSectionViewModel: ContentEquatable {
    public func isContentEqual(to source: TableViewSectionViewModel<HeaderFooterViewModel, CellViewModel>) -> Bool {
        return id.isContentEqual(to: source.id)
    }
}

extension TableViewSectionViewModel: ContentIdentifiable {
    public var differenceIdentifier: String {
        return id
    }
}

extension TableViewSectionViewModel: DifferentiableSection where
    CellViewModel: Hashable & Differentiable,
    HeaderFooterViewModel: Hashable & Differentiable {

    public init<C>(source: TableViewSectionViewModel,
                   elements: C) where C: Swift.Collection, C.Element == CellViewModel {
        self.init(
            id: source.id,
            header: source.header,
            footer: source.footer,
            cells: elements.map { $0 }
        )
    }

    public var elements: [CellViewModel] {
        return cells
    }

    public typealias Collection = [CellViewModel]
}
