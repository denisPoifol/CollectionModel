//
//  AnimatedTableViewDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 07/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CollectionModelCore
// MARK: - SimpleTableViewDataSource
class AnimatedTableViewDataSource: NSObject,
    UITableViewDataSource,
    UITableViewDelegate,
    EmptyInit,
    TableViewContent {

    typealias ViewModel = TableViewModel<Never, AnimatableTableViewCellModel>

    var viewModel = ViewModel(
        cells: [
            AnimatableTableViewCellModel(title: "Add cell", action: .addCell),
            AnimatableTableViewCellModel(title: "Shuffle cells", action: .shuffleCells),
        ]
    )

    required override init() {
        super.init()
    }

    func register(in tableView: UITableView) {
        tableView.register(cell: .class(AnimatableTableViewCell.self))
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
        let cell: AnimatableTableViewCell = tableView.dequeueCell(at: indexPath)
        cell.configure(with: viewModel[indexPath])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = viewModel[indexPath].action
        switch action {
        case .addCell:
            viewModel.sections[0].append(AnimatableTableViewCellModel(title: "Shuffle cells", action: .shuffleCells))
            tableView.reloadData()
        case .shuffleCells:
            // TODO: (Denis Poifol) 07/04/2020 Conforming to a specific protocol
            // could enable us to call shuffle on a section ?
            viewModel.sections[0].cells = viewModel.sections[0].shuffled()
            tableView.reloadData()
        }
    }
}
