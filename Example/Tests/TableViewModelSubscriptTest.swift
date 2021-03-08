//
//  TableViewModelSubscriptTest.swift
//  CollectionModel_Tests
//
//  Created by Denis Poifol on 08/03/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import CollectionModelCore

class TableViewModelSubscriptTest: XCTestCase {

    typealias ViewModel = TableViewModel<String, Int>
    typealias Section = ViewModel.Section
    var nonEmptyString = "someText"

    func testCellSubscript() {
        var viewModel = ViewModel {
            Section(header: nonEmptyString) {
                1
                2
                3
            }
        }
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssert(viewModel[indexPath] == 1, "Pass")
        viewModel[indexPath] = 13
        XCTAssert(viewModel[indexPath] == 13, "Pass")
        viewModel[indexPath] = 2
        XCTAssert(viewModel[indexPath] == 2, "Pass")
    }

    func testHeaderSubscript() {
        var viewModel = ViewModel {
            Section(header: nonEmptyString) {
                1
                2
                3
            }
        }
        XCTAssert(viewModel[header: 0] == nonEmptyString, "Pass")
        viewModel[header: 0] = nil
        XCTAssert(viewModel[header: 0] == nil, "Pass")
        viewModel[header: 0] = nonEmptyString
        XCTAssert(viewModel[header: 0] == nonEmptyString, "Pass")
    }

    func testFooterSubscript() {
        var viewModel = ViewModel {
            Section(footer: nonEmptyString) {
                1
                2
                3
            }
        }
        XCTAssert(viewModel[footer: 0] == nonEmptyString, "Pass")
        viewModel[footer: 0] = nil
        XCTAssert(viewModel[footer: 0] == nil, "Pass")
        viewModel[footer: 0] = nonEmptyString
        XCTAssert(viewModel[footer: 0] == nonEmptyString, "Pass")
    }
}
