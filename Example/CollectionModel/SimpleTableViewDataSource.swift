//
//  SimpleTableViewDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CollectionModel

// MARK: - SimpleTableViewDataSource
class SimpleTableViewDataSource: NSObject,
    UITableViewDataSource,
    UITableViewDelegate {

    typealias ViewModel = TableViewModel<Never, ATableViewCellModel>

    var viewModel = ViewModel(
        cells: [
            "some",
            "cells",
            "initialized",
            "with",
            "literal",
            "strings",
            ATableViewCellModel(title: "Or with the default initializer")
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
        let cell = ATableViewCell()
        cell.configure(with: viewModel[indexPath])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do something
    }
}
