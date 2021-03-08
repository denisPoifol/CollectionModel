//
//  TableViewModel+DifferenceKit.swift
//  CollectionModelAnimation
//
//  Created by Denis Poifol on 07/04/2020.
//

import Foundation
import CollectionModelCore
import DifferenceKit

extension TableViewSectionViewModel: ContentEquatable where
    HeaderFooterViewModel: ContentEquatable {
    public func isContentEqual(to source: TableViewSectionViewModel<HeaderFooterViewModel, CellViewModel>) -> Bool {
        return id.isContentEqual(to: source.id)
            && header.isContentEqual(to: source.header)
            && footer.isContentEqual(to: source.footer)
    }
}

extension TableViewSectionViewModel: ContentIdentifiable {
    public var differenceIdentifier: String {
        return id
    }
}

/// This conformance allows for DifferenceKit to create StagedChangeSet which in turn enable to animate changes.
/// If you find yourself unable to create a changeSet using StagedChangeSet(source:,target:) with you ViewModel
/// you should check on the conditions which are that your CellViewModel conforms to Differentiable
/// and HeaderFooterViewModel conforms to ContentEquatable.
/// Note that Never conformance to Differentiable is handled by this pod.
extension TableViewSectionViewModel: DifferentiableSection where
    CellViewModel: Differentiable,
    HeaderFooterViewModel: ContentEquatable {

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
