//
//  CollectionSectionViewModel.swift
//  CollectionModel
//
//  Created by Denis Poifol on 23/01/2020.
//

import Foundation

/// A struct representing as closely as possible the structure of a `UICollectionView` section.
/// It is generic over two parameters `SupplementaryViewModel` and `CellViewModel`
/// both parameters are self explanatory they should represent the model used to
/// configure the cells of the collectionView or the supplementary views which could
/// be a header a footer or a custom suplementary view
///
/// header and footer are stored appart from the suplementary views
public struct CollectionViewSectionViewModel<SupplementaryViewModel, CellViewModel> {

    /// Suplementary view are identified by an index path and their kind which is a string
    public struct SupplementaryViewSectionKey: Hashable {
        let row: Int
        let kind: String
    }

    /// The `SuplementaryViewModel` reprensenting the header of the section
    public var header: SupplementaryViewModel?
    /// The `SuplementaryViewModel` reprensenting the footer of the section
    public var footer: SupplementaryViewModel?
    /// A dictionary storing `SupplementaryViewModels` referenced by their row and kind
    /// Note that header and footer while being supplementary views are not handled by this dictionnary
    public var supplementaryViewModels: [SupplementaryViewSectionKey: SupplementaryViewModel]
    /// An `Array` of `CellViewModel` reprensenting the cells in the section
    public var cells: [CellViewModel]
    /// An id for the section. This id enables to use *DifferenceKit* to animate the collectionView changes
    public let id: String

    /// Creates an empty sectionViewModel
    public init() {
        self.init(cells: [])
    }

    /// Creates a sectionViewModel
    ///
    /// - Parameter id: An id for the section
    /// - Parameter supplementaryViewModels: A dictionnary mapping a `SupplementaryViewSectionKey`to a `SupplementaryViewModel`
    /// - Parameter header: A `SupplementaryViewModel` for the section header
    /// - Parameter footer: A `SupplementaryViewModel` for the section footer
    /// - Parameter cells: An array of `CellViewModel`
    public init(id: String = "",
                supplementaryViewModels: [SupplementaryViewSectionKey: SupplementaryViewModel] = [:],
                header: SupplementaryViewModel? = nil,
                footer: SupplementaryViewModel? = nil,
                cells: [CellViewModel]) {
        self.id = id
        self.header = header
        self.footer = footer
        self.supplementaryViewModels = supplementaryViewModels
        self.cells = cells
    }

    public subscript(index: SupplementaryViewSectionKey) -> SupplementaryViewModel? {
        supplementaryViewModels[index]
    }
}

extension CollectionViewSectionViewModel: RandomAccessCollection {
    public typealias Index = Int
    public typealias Element = CellViewModel

    public var startIndex: Int { cells.startIndex }
    public var endIndex: Int { cells.endIndex }

    public subscript(index: Index) -> Element {
        cells[index]
    }

    public func index(after i: Index) -> Index {
        cells.index(after: i)
    }
}

extension CollectionViewSectionViewModel: Equatable where CellViewModel: Equatable, SupplementaryViewModel: Equatable {}
extension CollectionViewSectionViewModel: Hashable where CellViewModel: Hashable, SupplementaryViewModel: Hashable {}

extension CollectionViewSectionViewModel: RangeReplaceableCollection {
    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C: Swift.Collection,
        R: RangeExpression,
        CellViewModel == C.Element,
        CollectionViewSectionViewModel<SupplementaryViewModel, CellViewModel>.Index == R.Bound {
            cells.replaceSubrange(subrange, with: newElements)
    }
}
