//
//  SimpleCollectionViewDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 27/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CollectionModel

// MARK: - SimpleCollectionViewDataSource
class SimpleCollectionViewDataSource: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    EmptyInit,
    CollectionViewContent {

    typealias ViewModel = CollectionViewModel<Never, String>

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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellIdentifier")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath)
        let label = UILabel()
        cell.contentView.addSubview(label)
        label.pinToSuperview()
        label.text = viewModel.cellViewModel(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Do someting
    }
}

