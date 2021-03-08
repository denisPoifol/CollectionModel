//
//  SupplementaryViewKey.swift
//  CollectionModel
//
//  Created by Denis Poifol on 27/08/2020.
//

import Foundation

/// Supplementary view are identified by an index path and their kind which is a string, `SupplementaryKey`
/// is a simple struct that regroup both information to easily access your SupplementaryView viewModel.
public struct SupplementaryViewKey: Hashable {

    public init(indexPath: IndexPath, kind: String) {
        self.indexPath = indexPath
        self.kind = kind
    }

    public let indexPath: IndexPath
    public let kind: String

    /// Returns the `SupplementaryViewSectionKey` built from the indexPath row and the kind stored by the `SupplementaryViewKey`
    public var sectionKey: SupplementaryViewSectionKey {
        SupplementaryViewSectionKey(row: indexPath.row, kind: kind)
    }
}


/// Supplementary view are identified by an index path and their kind which is a string, but in a given
///  section we only need a row indice. `SupplementaryViewSectionKey` is a simple struct that regroup
///  both information to easily access your SupplementaryView viewModel.
public struct SupplementaryViewSectionKey: Hashable {

    public init(row: Int, kind: String) {
        self.row = row
        self.kind = kind
    }

    public let row: Int
    public let kind: String
}
