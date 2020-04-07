//
//  SimpleCollectionViewDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 27/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CollectionModelCore

// MARK: - SimpleCollectionViewDataSource
class SimpleCollectionViewDataSource: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    EmptyInit,
    CollectionViewContent {

    typealias ViewModel = CollectionViewModel<Never, ACollectionViewCellModel>

    var viewModel = ViewModel(
        cells: [
            "some",
            "cells",
            "initialized",
            "with",
            "literal",
            "strings",
            "Or with the default initializer"
        ]
    )

    required override init() {
        super.init()
    }

    func register(in collectionView: UICollectionView) {
        collectionView.register(cell: .class(ACollectionViewCell.self))
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
        let cell: ACollectionViewCell = collectionView.dequeueCell(at: indexPath)
        cell.configure(with: viewModel.cellViewModel(at: indexPath))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Do someting
    }
}
