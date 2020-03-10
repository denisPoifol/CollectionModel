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
                                      didSelectCell: MainSectionCellViewModel) {
        // TODO: (Denis Poifol) 10/03/2020 ChangeViewController according to selected cell
        let viewController = UIViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
