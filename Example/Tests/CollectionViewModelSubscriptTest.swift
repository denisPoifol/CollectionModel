//
//  CollectionViewModelSubscriptTest.swift
//  CollectionModel_Tests
//
//  Created by Denis Poifol on 08/03/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import CollectionModelCore

class CollectionViewModelSubscriptTest: XCTestCase {

    typealias ViewModel = CollectionViewModel<String, Int>
    typealias Section = ViewModel.Section
    var nonEmptyString = "someText"

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
                4
            }
        }
        XCTAssert(viewModel[footer: 0] == nonEmptyString, "Pass")
        viewModel[footer: 0] = nil
        XCTAssert(viewModel[footer: 0] == nil, "Pass")
        viewModel[footer: 0] = nonEmptyString
        XCTAssert(viewModel[footer: 0] == nonEmptyString, "Pass")
    }

    func testCellSubscript() {
        var viewModel = ViewModel {
            Section(footer: nonEmptyString) {
                1
                2
            }
        }
        var indexPath = IndexPath(item: 0, section: 0)
        XCTAssert(viewModel[cellAt: indexPath] == 1, "Pass")
        indexPath = IndexPath(item: 1, section: 0)
        XCTAssert(viewModel[cellAt: indexPath] == 2, "Pass")
        indexPath = IndexPath(item: 0, section: 0)
        viewModel[cellAt: indexPath] = 15
        XCTAssert(viewModel[cellAt: indexPath] == 15, "Pass")
    }

    func testSupplementaryViewSubscript() {
        var viewModel = ViewModel {
            Section(footer: nonEmptyString) {
                1
                2
            }
        }
        let indexPath = IndexPath(
            item: 0,
            section: 0
        )
        let key = SupplementaryViewKey(indexPath: indexPath, kind: "supplementaryViewKind")
        XCTAssert(viewModel[supplementaryViewFor: key] == nil, "Pass")
        viewModel[supplementaryViewFor: key] = nonEmptyString
        XCTAssert(viewModel[supplementaryViewFor: key] == nonEmptyString, "Pass")
    }
}
