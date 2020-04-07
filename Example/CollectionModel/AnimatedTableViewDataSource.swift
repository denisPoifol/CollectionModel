//
//  AnimatedTableViewDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 07/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import DifferenceKit
import CollectionModelCore
import CollectionModelAnimation

// MARK: - SimpleTableViewDataSource
class AnimatedTableViewDataSource: NSObject,
    UITableViewDataSource,
    UITableViewDelegate,
    EmptyInit,
    TableViewContent {

    typealias ViewModel = TableViewModel<Never, AnimatableTableViewCellModel>

    var viewModel = ViewModel(
        cells: [
            AnimatableTableViewCellModel(id: UUID(), title: "Add cell", action: .addCell),
            AnimatableTableViewCellModel(id: UUID(), title: "Shuffle cells", action: .shuffleCells),
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
            var extendedViewModel = viewModel
            extendedViewModel.sections[0]
                .append(AnimatableTableViewCellModel(id: UUID(), title: "Shuffle cells", action: .shuffleCells))
            let changeSet = StagedChangeset<ViewModel>(source: viewModel, target: extendedViewModel)
            tableView.reload(using: changeSet, with: .automatic) { viewModel in
                self.viewModel = viewModel
            }
        case .shuffleCells:
            var shuffled = viewModel
            shuffled.sections[0].cells = shuffled.sections[0].shuffled()
            let changeSet = StagedChangeset<ViewModel>(source: viewModel, target: shuffled)
            tableView.reload(using: changeSet, with: .automatic) { viewModel in
                self.viewModel = viewModel
            }
        }
    }
}
