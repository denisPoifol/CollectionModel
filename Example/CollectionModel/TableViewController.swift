//
//  TableViewController.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController {

    private lazy var tableView = UITableView()
    private lazy var dataSource = SimpleTableViewDataSource()

    override func loadView() {
        view = tableView
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.smoothlyDeselectItems(in: transitionCoordinator)
    }
}
