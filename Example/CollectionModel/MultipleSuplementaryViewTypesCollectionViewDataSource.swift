//
//  MultipleSupplementaryViewTypesCollectionViewDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CollectionModelCore

// MARK: - MultipleHeaderFooterModel
enum MultipleSupplementaryViewModel {
    case aSupplementaryView(ACollectionViewSupplementaryViewModel)
    case bSupplementaryView(BCollectionViewSupplementaryViewModel)
}

// MARK: - MultipleCellTypesCollectionViewDataSource
class MultipleSupplementaryViewCollectionViewDataSource: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    EmptyInit,
    CollectionViewContent {

    typealias ViewModel = CollectionViewModel<MultipleSupplementaryViewModel, MultipleCellTypesCollectionViewCellModel>

    // Using Declarative view builder init for ViewModel
    var viewModel = ViewModel {
        // Using Declarative view builder init for ViewModel.Section
        ViewModel.Section(
            header: .aSupplementaryView("headser of type A"),
            footer: .bSupplementaryView("footer of type B")
        ) {
                MultipleCellTypesCollectionViewCellModel.a("Some A cell")
                MultipleCellTypesCollectionViewCellModel.b("Some B cell")
        }
        ViewModel.Section(
            header: .bSupplementaryView("header of type B"),
            footer: .aSupplementaryView("footer of type A"),
            cells: [
                .a("Some A cell"),
                .b("Some B cell"),
            ]
        )
        ViewModel.Section(
            footer: .bSupplementaryView("footer of type A"),
            cells: [
                .a("Some A cell"),
                .b("Some B cell"),
            ]
        )
        ViewModel.Section(
            header: .bSupplementaryView("header of type B"),
            cells: [
                .a("Some A cell"),
                .b("Some B cell"),
            ]
        )
    }

    required override init() {
        super.init()
    }

    func register(in collectionView: UICollectionView) {
        collectionView.register(cell: .class(ACollectionViewCell.self))
        collectionView.register(cell: .class(BCollectionViewCell.self))
        collectionView.register(header: .class(ACollectionViewSupplementaryView.self))
        collectionView.register(footer: .class(ACollectionViewSupplementaryView.self))
        collectionView.register(header: .class(BCollectionViewSupplementaryView.self))
        collectionView.register(footer: .class(BCollectionViewSupplementaryView.self))
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

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard viewModel.headers[section] != nil else { return .zero }
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        guard viewModel.footers[section] != nil else { return .zero }
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            guard let headerViewModel = viewModel.headers[indexPath.section] else { break }
            return dequeueHeader(in: collectionView, at: indexPath, with: headerViewModel)
        case UICollectionElementKindSectionFooter:
            guard let headerViewModel = viewModel.footers[indexPath.section] else { break }
            return dequeueFooter(in: collectionView, at: indexPath, with: headerViewModel)
        default:
            break
        }
        assertionFailure(
            "[\(type(of: self))] failed to create supplementary view for indexPath: \(indexPath) of kind: \(kind)"
        )
        return UICollectionReusableView()
    }

    // MARK: - Private

    private func dequeueHeader(in collectionView: UICollectionView,
                               at indexPath: IndexPath,
                               with headerViewModel: MultipleSupplementaryViewModel) -> UICollectionReusableView {
        switch headerViewModel {
        case let .aSupplementaryView(headerViewModel):
            let header: ACollectionViewSupplementaryView = collectionView.dequeueHeader(at: indexPath)
            header.configure(with: headerViewModel)
            return header
        case let .bSupplementaryView(headerViewModel):
            let header: BCollectionViewSupplementaryView = collectionView.dequeueHeader(at: indexPath)
            header.configure(with: headerViewModel)
            return header
        }
    }

    private func dequeueFooter(in collectionView: UICollectionView,
                               at indexPath: IndexPath,
                               with headerViewModel: MultipleSupplementaryViewModel) -> UICollectionReusableView {
        switch headerViewModel {
        case let .aSupplementaryView(headerViewModel):
            let header: ACollectionViewSupplementaryView = collectionView.dequeueFooter(at: indexPath)
            header.configure(with: headerViewModel)
            return header
        case let .bSupplementaryView(headerViewModel):
            let header: BCollectionViewSupplementaryView = collectionView.dequeueFooter(at: indexPath)
            header.configure(with: headerViewModel)
            return header
        }
    }
}
