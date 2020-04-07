//
//  TableViewModel.swift
//  CollectionModel
//
//  Created by Denis Poifol on 23/01/2020.
//

import Foundation
import UIKit

/// A struct representing as closely as possible the structure of a `UITableView`.
/// It is generic over two parameters `HeaderFooterViewModel` and `CellViewModel`
/// both parameters are self explanatory, they should represent the model used to
/// configure the cells of the tableView or the headers and footers
///
/// This struct is mainly a wrapper for an array of `TableSectionViewModel`
/// which is a struct representing a section of `UITableView`
///
public struct TableViewModel<HeaderFooterViewModel, CellViewModel> {
    public typealias Section = TableViewSectionViewModel<HeaderFooterViewModel, CellViewModel>

    /// An array of the section viewModels
    public var sections: [Section]

    /// Creates a viewModel containing a section initialized with the given cells
    ///
    /// - Parameter cells: An array of `CellViewModel`
    public init(cells: [CellViewModel]) {
        let section = Section(cells: cells)
        self.init(section: section)
    }

    /// Creates a viewModel containing the given sections
    ///
    /// - Parameter sections: The sections to be contained in the viewModel
    public init(section: Section) {
        self.init(sections: [section])
    }

    /// Creates a viewModel containing no sections
    public init() {
        self.init(sections: [])
    }

    /// Creates a viewModel containing a single section
    ///
    /// - Parameter section: The section contained in the viewModel``
    public init(sections: [Section]) {
        self.sections = sections
    }

    /// A lazy collection of the sections header
    public var headers: LazyMapCollection<[Section], HeaderFooterViewModel?> { sections.lazy.map { $0.header } }
    /// A lazy collection of the sections footer
    public var footers: LazyMapCollection<[Section], HeaderFooterViewModel?> { sections.lazy.map { $0.footer } }

    /// Return the `CellViewModel` corresponding to the given `IndexPath`
    ///
    /// - Parameter indexPath: A valid index path for the given collectionViewModel
    /// - Returns: The viewModel representing the cell
    public subscript(indexPath: IndexPath) -> CellViewModel {
        return sections[indexPath.section][indexPath.row]
    }
}

extension TableViewModel: Equatable where CellViewModel: Equatable, HeaderFooterViewModel: Equatable {}
extension TableViewModel: Hashable where CellViewModel: Hashable, HeaderFooterViewModel: Hashable {}

extension TableViewModel: Collection {
    public typealias Index = Int
    public typealias Element = TableViewSectionViewModel<HeaderFooterViewModel, CellViewModel>

    public var startIndex: Int { sections.startIndex }
    public var endIndex: Int { sections.endIndex }

    public subscript(index: Index) -> Section {
        get { sections[index] }
        set { sections[index] = newValue }
    }

    public func index(after i: Index) -> Index {
        return sections.index(after: i)
    }
}

extension TableViewModel: RangeReplaceableCollection {
    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C: Swift.Collection,
        R: RangeExpression,
        TableViewSectionViewModel<HeaderFooterViewModel, CellViewModel> == C.Element,
        TableViewModel<HeaderFooterViewModel, CellViewModel>.Index == R.Bound {
            sections.replaceSubrange(subrange, with: newElements)
    }
}
