//
//  MainViewControllerDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 25/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CollectionModelCore

// MARK: - ViewModel for the main viewController cells
enum MainSectionCellViewModel {
    // MARK: - TableView
    case simpleTableViewCell
    case multipleTableViewCells
    case multipleHeaderFooterTypes
    // MARK: - CollectionView
    case simpleCollectionViewCell
    case multipleCollectionViewCells
    case multipleSupplementaryViews
    // MARK: - Animating TableView
    case animatedTableViewCells
    case animatedCollectionViewCells

    var title: String {
        switch self {
        case .simpleTableViewCell:
            return "Simple"
        case .multipleTableViewCells:
            return "Multiple cell type"
        case .multipleHeaderFooterTypes:
            return "Multiple headerFooter type"
        case .simpleCollectionViewCell:
            return "Simple"
        case .multipleCollectionViewCells:
            return "Multiple cell type"
        case .multipleSupplementaryViews:
            return "Multiple supplementaryView type"
        case .animatedTableViewCells:
            return "Animate tableView changes"
        case .animatedCollectionViewCells:
            return "Animate collectionView changes"
        }
    }
}

// MARK: - SectionMainViewControllerDataSourceDelegate
protocol MainViewControllerDataSourceDelegate: AnyObject {
    func mainViewControllerDataSource(_ dataSource: MainViewControllerDataSource,
                                      didSelectCell: MainSectionCellViewModel)
}

// MARK: - MainViewControllerDataSource
class MainViewControllerDataSource: NSObject,
    UITableViewDataSource,
    UITableViewDelegate {

    typealias ViewModel = TableViewModel<String, MainSectionCellViewModel>

    weak var delegate: MainViewControllerDataSourceDelegate?
    private let viewModel = ViewModel(
        sections: [
            ViewModel.Section(
                header: "TableViews",
                cells: [
                    .simpleTableViewCell,
                    .multipleTableViewCells,
                    .multipleHeaderFooterTypes,
                ]
            ),
            ViewModel.Section(
                header: "CollectionViews",
                cells: [
                    .simpleCollectionViewCell,
                    .multipleCollectionViewCells,
                    .multipleSupplementaryViews,
                ]
            ),
            ViewModel.Section(
                header: "Animations",
                cells: [
                    .animatedTableViewCells,
                    .animatedCollectionViewCells,
                ]
            )
        ]
    )

    func numberOfSections(in tableView: UITableView) -> Int {
        // viewModel.count also works
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // viewModel.sections[section].cells.count
        // viewModel.sections[section].count
        // viewModel[section].count are viable options
        viewModel[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel[indexPath].title
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel[section].header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.mainViewControllerDataSource(self, didSelectCell: viewModel[indexPath])
    }
}

