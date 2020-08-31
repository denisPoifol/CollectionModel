import XCTest
import CollectionModelCore

class CollectionViewModelFunctionBuilderTest: XCTestCase {

    typealias ViewModel = CollectionViewModel<String, Int>
    typealias Section = ViewModel.Section

    // These test make sur compilation is successfull with function builders
    func testDeclarativeFunctionBuilder() {
        // MARK: - single section
        let section = Section()
        _ = CollectionViewModel {
            section
        }
        // MARK: - multiple section
        _ = CollectionViewModel {
            section
            section
        }
        // MARK: - section and collection of sections
        _ = CollectionViewModel {
            section
            [
                section,
                section,
            ]
        }
        // MARK: - if else statement
        _ = CollectionViewModel {
            section
            if Bool.random() {
                [
                    section,
                    section,
                ]
            } else {
                section
            }
        }
        XCTAssert(true, "Pass")
    }

    func testDeclarativeFunctionBuilderSection() {
        // MARK: - single section
        let cell = 1
        _ = Section {
            cell
        }
        // MARK: - multiple cell
        _ = Section {
            cell
            cell
        }
        // MARK: - cell and collection of cells
        _ = Section {
            cell
            [
                cell,
                cell,
            ]
        }
        // MARK: - if else statement
        _ = Section {
            cell
            if Bool.random() {
                [
                    cell,
                    cell,
                ]
            } else {
                cell
            }
        }
        XCTAssert(true, "Pass")
    }    
}
