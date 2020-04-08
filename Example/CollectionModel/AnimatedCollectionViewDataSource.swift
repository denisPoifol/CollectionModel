//
//  AnimatedCollectionViewDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 07/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CollectionModelCore
import CollectionModelAnimation
import DifferenceKit

// MARK: - SimpleCollectionViewDataSource
class AnimatedCollectionViewDataSource: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    EmptyInit,
    CollectionViewContent {

    typealias ViewModel = CollectionViewModel<Never, AnimatableCollectionViewCellModel>

    var viewModel = ViewModel(
        cells: [
            AnimatableCollectionViewCellModel(id: UUID(), title: "Add cell", action: .addCell),
            AnimatableCollectionViewCellModel(id: UUID(), title: "Shuffle cells", action: .shuffleCells),
        ]
    )

    required override init() {
        super.init()
    }

    func register(in collectionView: UICollectionView) {
        collectionView.register(cell: .class(AnimatableCollectionViewCell.self))
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
        let cell: AnimatableCollectionViewCell = collectionView.dequeueCell(at: indexPath)
        cell.configure(with: viewModel.cellViewModel(at: indexPath))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = viewModel.cellViewModel(at: indexPath).action
        switch action {
        case .addCell:
            var extendedViewModel = viewModel
            extendedViewModel.sections[0]
                .append(AnimatableCollectionViewCellModel(id: UUID(), title: "Shuffle cells", action: .shuffleCells))
            let changeSet = StagedChangeset<ViewModel>(source: viewModel, target: extendedViewModel)
            collectionView.reload(using: changeSet) { viewModel in
                self.viewModel = viewModel
            }
        case .shuffleCells:
            var shuffled = viewModel
            shuffled.sections[0].cells = shuffled.sections[0].shuffled()
            let changeSet = StagedChangeset<ViewModel>(source: viewModel, target: shuffled)
            collectionView.reload(using: changeSet) { viewModel in
                self.viewModel = viewModel
            }
        }
    }
}

