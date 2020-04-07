//
//  ViewController.swift
//  CollectionModel
//
//  Created by Denis Poifol on 01/23/2020.
//  Copyright (c) 2020 Denis Poifol. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,
    MainViewControllerDataSourceDelegate {

    private lazy var tableView = UITableView()
    private lazy var dataSource = MainViewControllerDataSource()

    override func loadView() {
        view = tableView
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        dataSource.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.smoothlyDeselectItems(in: transitionCoordinator)
    }

    // MARK: - MainViewControllerDataSourceDelegate

    func mainViewControllerDataSource(_ dataSource: MainViewControllerDataSource,
                                      didSelectCell cell: MainSectionCellViewModel) {
        let viewController: UIViewController
        switch cell {
        case .simpleTableViewCell:
            viewController = TableViewController<SimpleTableViewDataSource>()
        case .multipleTableViewCells:
            viewController = TableViewController<MultipleCellTypesTableViewDataSource>()
        case .multipleHeaderFooterTypes:
            viewController = TableViewController<MultipleHeaderFooterTypesTableViewDataSource>()
        case .simpleCollectionViewCell:
            viewController = CollectionViewController<SimpleCollectionViewDataSource>()
        case .multipleCollectionViewCells:
            viewController = CollectionViewController<MultipleCellTypesCollectionViewDataSource>()
        case .multipleSupplementaryViews:
            viewController = CollectionViewController<MultipleSuplementaryViewCollectionViewDataSource>()
        case .animateTableViewCells:
            viewController = AnimatedTableViewController()
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
