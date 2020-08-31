import XCTest
import CollectionModelCore

class TableViewModelEntityFunctionBuilderTest: XCTestCase {

    typealias ViewModel = TableViewModel<String, CellViewModel>
    typealias Section = ViewModel.Section
    typealias CellViewModel = Int
    var entities = (1...10).map { $0 }

    // These test make sur compilation is successfull with function builders
    func testDeclarativeFunctionBuilder() {
        // MARK: - single section
        _ = ViewModel(entities: entities) {
            section(for: $0)
        }
        // MARK: - multiple section
        _ = ViewModel(entities: entities) {
            section(for: $0)
            section(for: $0)
        }
        // MARK: - section and collection of sections
        _ = ViewModel(entities: entities) {
            section(for: $0)
            [
                section(for: $0),
                section(for: $0),
            ]
        }
        // MARK: - if else statement
        _ = ViewModel(entities: entities) {
            section(for: $0)
            if Bool.random() {
                [
                    section(for: $0),
                    section(for: $0),
                ]
            } else {
                section(for: $0)
            }
        }
        XCTAssert(true, "Pass")
    }

    func testDeclarativeFunctionBuilderSection() {
        // MARK: - single section
        _ = Section(entities: entities) {
            cell(for: $0)
        }
        // MARK: - multiple cell
        _ = Section(entities: entities) {
            cell(for: $0)
            cell(for: $0)
        }
        // MARK: - cell and collection of cells
        _ = Section(entities: entities) {
            cell(for: $0)
            [
                cell(for: $0),
                cell(for: $0),
            ]
        }
        // MARK: - if else statement
        _ = Section(entities: entities) {
            cell(for: $0)
            if Bool.random() {
                [
                    cell(for: $0),
                    cell(for: $0),
                ]
            } else {
                cell(for: $0)
            }
        }
        XCTAssert(true, "Pass")
    }

    // MARK: - Private

    private func cell(for entity: Int) -> CellViewModel {
        entity
    }

    private func section(for entity: Int) -> Section {
        Section()
    }
}
