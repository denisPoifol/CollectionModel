//
//  MultipleCellTypesTableViewDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CollectionModelCore

// MARK: - MultipleCellTypesTableViewCellModel
enum MultipleCellTypesTableViewCellModel {
    case a(ATableViewCellModel)
    case b(BTableViewCellModel)
}

// MARK: - MultipleCellTypesTableViewDataSource
class MultipleCellTypesTableViewDataSource: NSObject,
    UITableViewDataSource,
    UITableViewDelegate,
    EmptyInit,
    TableViewContent {

    typealias ViewModel = TableViewModel<Never, MultipleCellTypesTableViewCellModel>

    var viewModel = ViewModel(
        cells: [
            .a("some (type A)"),
            .b("cells (type B)"),
            .a("initialized (type A)"),
            .b("with (type B)"),
            .a("literal (type A)"),
            .b("strings (type B)"),
        ]
    )

    required override init() {
        super.init()
    }

    func register(in tableView: UITableView) {
        tableView.register(cell: .class(ATableViewCell.self))
        tableView.register(cell: .class(BTableViewCell.self))
    }

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
        switch viewModel[indexPath] {
        case let .a(cellViewModel):
            let cell: ATableViewCell = tableView.dequeueCell(at: indexPath)
            cell.configure(with: cellViewModel)
            cell.selectionStyle = .none
            return cell
        case let .b(cellViewModel):
            let cell: BTableViewCell = tableView.dequeueCell(at: indexPath)
            cell.configure(with: cellViewModel)
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do something
    }
}

