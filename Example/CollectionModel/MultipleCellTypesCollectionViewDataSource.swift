//
//  MultipleCellTypesCollectionViewDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CollectionModel

// MARK: - MultipleCellTypesCollectionViewCellModel
enum MultipleCellTypesCollectionViewCellModel {
    case a(ACollectionViewCellModel)
    case b(BCollectionViewCellModel)
}

// MARK: - MultipleCellTypesCollectionViewDataSource
class MultipleCellTypesCollectionViewDataSource: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    EmptyInit,
    CollectionViewContent {

    typealias ViewModel = CollectionViewModel<Never, MultipleCellTypesCollectionViewCellModel>

    var viewModel = ViewModel(
        cells: [
            .a("some (type A)"),
            .b("cells (type B)"),
            .a("initialized (type A)"),
            .b("with (type B)"),
            .a("literal (type A)"),
            .b("strings (type B)"),
        ]
    )

    required override init() {
        super.init()
    }

    func register(in collectionView: UICollectionView) {
        collectionView.register(cell: .class(ACollectionViewCell.self))
        collectionView.register(cell: .class(BCollectionViewCell.self))
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // viewModel.count also works
        viewModel.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // viewModel.sections[section].cells.count
        // viewModel.sections[section].count
        // viewModel[section].count are viable options
        viewModel[section].cells.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.cellViewModel(at: indexPath) {
        case let .a(cellViewModel):
            let cell: ACollectionViewCell = collectionView.dequeueCell(at: indexPath)
            cell.configure(with: cellViewModel)
            return cell
        case let .b(cellViewModel):
            let cell: BCollectionViewCell = collectionView.dequeueCell(at: indexPath)
            cell.configure(with: cellViewModel)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Do someting
    }
}


