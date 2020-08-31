//
//  ViewModelFromEntityFunctionBuilder.swift
//  CollectionModelAnimation
//
//  Created by Denis Poifol on 28/08/2020.
//

import Foundation

@_functionBuilder
public struct ViewModelFromEntityFunctionBuilder<ViewModel, Entity> {
    let entity: Entity

    public static func buildExpression(_ viewModel: ViewModel) -> [ViewModel] {
        [viewModel]
    }

    public static func buildBlock(_ viewModels: [ViewModel]...) -> [ViewModel] {
        viewModels.flatMap { $0 }
    }

    public static func buildIf(_ viewModel: [ViewModel]?) -> [ViewModel] {
        viewModel ?? []
    }

    public static func buildEither(first: [ViewModel]) -> [ViewModel] {
        first
    }

    public static func buildEither(second: [ViewModel]) -> [ViewModel] {
        second
    }
}

// MARK: - CollectionViewModel

public extension CollectionViewModel {
    /// Creates a collection viewModel building an array of section for each entity by using a function
    /// builder
    ///
    /// - Parameter entities: An array of entities used to create your cells
    /// - Parameter sectionBuilder: returns an array of section for each entity in the `entities` array
    init<T>(entities: [T],
            @ViewModelFromEntityFunctionBuilder<Section, T> sectionBuilder: (T) -> [Section]) {
        self.sections = entities.flatMap(sectionBuilder)
    }
}

// MARK: - CollectionViewSectionViewModel

public extension CollectionViewSectionViewModel {
    /// Creates a section viewModel building an array of cells for each entity by using a function builder
    /// the other parameters remaind unchanged from classic function declaration
    ///
    /// - Parameter entities: An array of entities used to create your cells
    /// - Parameter id: An id for the section
    /// - Parameter supplementaryViewModels: A dictionnary mapping a `SupplementaryViewSectionKey`to a `SupplementaryViewModel`
    /// - Parameter header: A `SupplementaryViewModel` for the section header
    /// - Parameter footer: A `SupplementaryViewModel` for the section footer
    /// - Parameter cellsBuilder: returns an array of cells for each entity in the `entities` array
    init<T>(entities: [T],
            id: String = "",
            header: SupplementaryViewModel? = nil,
            footer: SupplementaryViewModel? = nil,
            supplementaryViewModels: [SupplementaryViewSectionKey: SupplementaryViewModel] = [:],
            @ViewModelFromEntityFunctionBuilder<CellViewModel, T> cellsBuilder: (T) -> [CellViewModel]) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = entities.flatMap(cellsBuilder)
        self.supplementaryViewModels = supplementaryViewModels
    }
}

// MARK: - TableViewModel

public extension TableViewModel {
    /// Creates a table viewModel building an array of section for each entity by using a function builder
    ///
    /// - Parameter entities: An array of entities used to create your cells
    /// - Parameter sectionBuilder: returns an array of section for each entity in the `entities` array
    init<T>(entities: [T],
            @ViewModelFromEntityFunctionBuilder<Section, T> sectionBuilder: (T) -> [Section]) {
        self.sections = entities.flatMap(sectionBuilder)
    }
}

// MARK: - TableViewSectionViewModel

public extension TableViewSectionViewModel {
    /// Creates a section viewModel building an array of cells for each entity by using a function builder
    /// the other parameters remaind unchanged from classic function declaration
    ///
    /// - Parameter entities: An array of entities used to create your cells
    /// - Parameter id: An id for the section
    /// - Parameter header: A `SupplementaryViewModel` for the section header
    /// - Parameter footer: A `SupplementaryViewModel` for the section footer
    /// - Parameter cellsBuilder: returns an array of cells for each entity in the `entities` array
    init<T>(entities: [T],
            id: String = "",
            header: HeaderFooterViewModel? = nil,
            footer: HeaderFooterViewModel? = nil,
            @ViewModelFromEntityFunctionBuilder<CellViewModel, T> cellsBuilder: (T) -> [CellViewModel]) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = entities.flatMap(cellsBuilder)
    }
}
