//
//  TableSectionViewModel.swift
//  CollectionModel
//
//  Created by Denis Poifol on 23/01/2020.
//

import Foundation

/// A struct representing as closely as possible the structure of a `UITableView` section.
/// It is generic over two parameters `HeaderFooterViewModel` and `CellViewModel`
/// both parameters are self explanatory, they should represent the model used to
/// configure the cells of the tableView or the headers and footers
public struct TableViewSectionViewModel<HeaderFooterViewModel, CellViewModel> {

    /// The `SupplementaryViewModel` representing the header of the section
    public var header: HeaderFooterViewModel?
    /// The `SupplementaryViewModel` representing the footer of the section
    public var footer: HeaderFooterViewModel?
    /// An `Array` of `CellViewModel` representing the cells in the section
    public var cells: [CellViewModel]
    /// An id for the section. This id enables to use *DifferenceKit* to animate the collectionView changes
    public var id: String

    /// Creates a sectionViewModel
    ///
    /// - Parameter id: An id for the section
    /// - Parameter header: A `HeaderFooterViewModel` for the section header
    /// - Parameter footer: A `HeaderFooterViewModel` for the section footer
    /// - Parameter cells: An array of `CellViewModel`
    public init(id: String = "",
                header: HeaderFooterViewModel? = nil,
                footer: HeaderFooterViewModel? = nil,
                cells: [CellViewModel]) {
        self.id = id
        self.header = header
        self.cells = cells
        self.footer = footer
    }

    /// Creates an empty sectionViewModel
    public init() {
        self.init(cells: [])
    }
}

extension TableViewSectionViewModel: RandomAccessCollection {
    public typealias Index = Int
    public typealias Element = CellViewModel

    public var startIndex: Int { cells.startIndex }
    public var endIndex: Int { cells.endIndex }

    public subscript(index: Index) -> CellViewModel {
        get { cells[index] }
        set { cells[index] = newValue }
    }

    public func index(after i: Index) -> Index {
        cells.index(after: i)
    }
}

extension TableViewSectionViewModel: Equatable where CellViewModel: Equatable, HeaderFooterViewModel: Equatable {}
extension TableViewSectionViewModel: Hashable where CellViewModel: Hashable, HeaderFooterViewModel: Hashable {}

extension TableViewSectionViewModel: RangeReplaceableCollection {

    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C: Swift.Collection,
        R: RangeExpression,
        CellViewModel == C.Element,
        TableViewSectionViewModel<HeaderFooterViewModel, CellViewModel>.Index == R.Bound {
            cells.replaceSubrange(subrange, with: newElements)
    }
}
