//
//  MultipleHeaderFooterTypesTableViewDataSource.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CollectionModel

// MARK: - MultipleHeaderFooterModel
enum MultipleHeaderFooterModel {
    case aHeaderFooter(ATableViewHeaderFooterViewModel)
    case bHeaderFooter(BTableViewHeaderFooterViewModel)
}

// MARK: - MultipleHeaderFooterTypesTableViewDataSource
class MultipleHeaderFooterTypesTableViewDataSource: NSObject,
    UITableViewDataSource,
    UITableViewDelegate,
    EmptyInit {

    typealias ViewModel = TableViewModel<MultipleHeaderFooterModel, MultipleCellTypesTableViewCellModel>

    // both type of headerFooter can be used both as header and as footer.
    var viewModel = ViewModel(
        sections: [
            ViewModel.Section(
                header: .aHeaderFooter("headser of type A"),
                footer: .bHeaderFooter("footer of type B"),
                cells: [
                    .a("Some A cell"),
                    .b("Some B cell"),
                ]
            ),
            ViewModel.Section(
                header: .bHeaderFooter("header of type B"),
                footer: .aHeaderFooter("footer of type A"),
                cells: [
                    .a("Some A cell"),
                    .b("Some B cell"),
                ]
            ),
            ViewModel.Section(
                footer: .bHeaderFooter("footer of type A"),
                cells: [
                    .a("Some A cell"),
                    .b("Some B cell"),
                ]
            ),
            ViewModel.Section(
                header: .bHeaderFooter("header of type B"),
                cells: [
                    .a("Some A cell"),
                    .b("Some B cell"),
                ]
            )
        ]
    )

    required override init() {
        super.init()
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
            let cell = ATableViewCell()
            cell.configure(with: cellViewModel)
            cell.selectionStyle = .none
            return cell
        case let .b(cellViewModel):
            let cell = BTableViewCell()
            cell.configure(with: cellViewModel)
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerViewModel = viewModel[section].header else { return nil }
        return headerFooter(for: headerViewModel)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let headerViewModel = viewModel[section].footer else { return nil }
        return headerFooter(for: headerViewModel)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard viewModel[section].footer != nil else { return 0 }
        return tableView.sectionFooterHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel[section].header != nil else { return 0 }
        return tableView.sectionFooterHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do something
    }

    // MARK: - Private

    private func headerFooter(for viewModel: MultipleHeaderFooterModel) -> UIView {
        switch viewModel {
        case let .aHeaderFooter(headerFooter):
            let view = ATableViewHeaderFooterView()
            view.configure(with: headerFooter)
            return view
        case let .bHeaderFooter(headerFooter):
            let view = BTableViewHeaderFooterView()
            view.configure(with: headerFooter)
            return view
        }
    }
}

