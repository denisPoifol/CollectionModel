//
//  AnimatedTableViewController.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 07/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class AnimatedTableViewController: UIViewController {

    private lazy var tableView = UITableView()
    private lazy var dataSource = AnimatedTableViewDataSource()

    override func loadView() {
        view = tableView
        dataSource.register(in: tableView)
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
