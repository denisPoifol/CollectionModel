//
//  CollectionViewModel.swift
//  CollectionModel
//
//  Created by Denis Poifol on 23/01/2020.
//

import Foundation
import UIKit

/// A struct representing as closely as possible the structure of a `UICollectionView`.
/// It is generic over two parameters `SupplementaryViewModel` and `CellViewModel`
/// both parameters are self explanatory they should represent the models used to
/// configure the cells of the collectionView or the supplementary views which could
/// be a header a footer or a custom supplementary view
///
/// This struct is mainly a wrapper for an array of `CollectionSectionViewModel`
/// which is a struct representing a section of `UICollectionView`
///
public struct CollectionViewModel<SupplementaryViewModel, CellViewModel> {
    public typealias Section = CollectionViewSectionViewModel<SupplementaryViewModel, CellViewModel>

    /// An array of the section viewModels
    public var sections: [CollectionViewSectionViewModel<SupplementaryViewModel, CellViewModel>]

    /// Creates a viewModel containing the given sections
    ///
    /// - Parameter sections: The sections to be contained in the viewModel
    public init(sections: [Section]) {
        self.sections = sections
    }

    /// Creates a viewModel containing a section initialized with the given cells
    ///
    /// - Parameter cells: An array of `CellViewModel`
    public init(cells: [CellViewModel]) {
        let section = Section(cells: cells)
        self.init(section: section)
    }

    /// Creates a viewModel containing a single section
    ///
    /// - Parameter section: The section contained in the viewModel``
    public init(section: Section) {
        self.init(sections: [section])
    }

    /// Creates a viewModel containing no sections
    public init() {
        self.init(sections: [])
    }

    /// A lazy collection of the sections header
    public var headers: LazyMapCollection<[Section], SupplementaryViewModel?> { sections.lazy.map { $0.header } }
    /// A lazy collection of the sections footer
    public var footers: LazyMapCollection<[Section], SupplementaryViewModel?> { sections.lazy.map { $0.footer } }

    /// Return the `CellViewModel` corresponding to the given `IndexPath`
    ///
    /// - Parameter indexPath: A valid index path for the given collectionViewModel
    /// - Returns: The viewModel representing the cell
    public func cellViewModel(at indexPath: IndexPath) -> CellViewModel {
        sections[indexPath.section][indexPath.row]
    }

    /// Return the `SupplementaryViewModel` corresponding to the given `SupplementaryViewKey`
    ///
    /// - Parameter key: A `SupplementaryViewKey` formed with an `IndexPath` and specific supplementaryView kind
    /// - Returns: The viewModel representing the supplementary view if it exists
    public func supplementaryViewModel(for key: SupplementaryViewKey) -> SupplementaryViewModel? {
        guard sections.count > key.indexPath.section else { return nil }
        let sectionKey = SupplementaryViewSectionKey(row: key.indexPath.row, kind: key.kind)
        return sections[key.indexPath.section][sectionKey]
    }

    /// Return the `SupplementaryViewModel` corresponding to the header of footer of the given section index
    /// This can also be achieved with `sections[sectionIndex].header`/`sections[sectionIndex].footer` or
    /// even `headers[sectionIndex]`/`footers[sectionIndex`
    ///
    /// - Parameter kind: A supplementaryView kind that needs to be either `UICollectionView.elementKindSectionHeader` or `UICollectionView.elementKindSectionFooter` for the function not to return `nil`
    /// - Parameter section: The section index of which you want to retrieve the viewModel
    /// - Returns: The viewModel representing the supplementary view if it exists
    public func headerOrFooterViewModel(forKind kind: String, inSection section: Int) -> SupplementaryViewModel? {
        guard sections.indices.contains(section) else { return nil }
        let section = sections[section]
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return section.header
        case UICollectionView.elementKindSectionFooter:
            return section.footer
        default:
            return nil
        }
    }

    /// Return the number of items in the section
    ///
    /// - Parameter section: The section for which we want the number of items
    public func numberOfItemsInSection(_ section: Int) -> Int {
        sections[section].cells.count
    }
}

extension CollectionViewModel: RandomAccessCollection {
    public typealias Index = Int
    public typealias Element = CollectionViewSectionViewModel<SupplementaryViewModel, CellViewModel>

    public var startIndex: Int { return sections.startIndex }
    public var endIndex: Int { return sections.endIndex }

    public subscript(index: Index) -> Element {
        get { sections[index] }
        set { sections[index] = newValue }
    }

    public func index(after i: Index) -> Index {
        sections.index(after: i)
    }
}

extension CollectionViewModel: Equatable where CellViewModel: Equatable, SupplementaryViewModel: Equatable {}
extension CollectionViewModel: Hashable where CellViewModel: Hashable, SupplementaryViewModel: Hashable {}

extension CollectionViewModel: RangeReplaceableCollection {
    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C: Swift.Collection,
        R: RangeExpression,
        CollectionViewSectionViewModel<SupplementaryViewModel, CellViewModel> == C.Element,
        CollectionViewModel<SupplementaryViewModel, CellViewModel>.Index == R.Bound {
            sections.replaceSubrange(subrange, with: newElements)
    }
}
