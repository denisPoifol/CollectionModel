//
//  SupplementaryViewKey.swift
//  CollectionModel
//
//  Created by Denis Poifol on 27/08/2020.
//

import Foundation

/// Suplementary view are identified by an index path and their kind which is a string, `SupplementaryKey`
/// is a simple struct that regroup both information to easily access your SupplementaryView viewModel.
public struct SupplementaryViewKey: Hashable {

    public init(indexPath: IndexPath, kind: String) {
        self.indexPath = indexPath
        self.kind = kind
    }

    public let indexPath: IndexPath
    public let kind: String
}
