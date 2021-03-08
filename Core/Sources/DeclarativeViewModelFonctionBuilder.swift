//
//  DeclarativeViewModelFonctionBuilder.swift
//  CollectionModelAnimation
//
//  Created by Denis Poifol on 28/08/2020.
//

import Foundation

@_functionBuilder
public struct DeclarativeViewModelFonctionBuilder<ViewModel> {
    public static func buildExpression(_ viewModel: ViewModel) -> [ViewModel] {
        [viewModel]
    }

    public static func buildExpression(_ viewModels: [ViewModel]) -> [ViewModel] {
        viewModels
    }

    public static func buildExpression<C: Collection>(_ viewModels: C) -> [ViewModel]
        where C.Element == ViewModel {
        viewModels.map { $0 }
    }

    public static func buildBlock(_ viewModels: [ViewModel]...) -> [ViewModel] {
        viewModels.flatMap { $0 }
    }

    public static func buildBlock(_ viewModels: ViewModel...) -> [ViewModel] {
        viewModels
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
    /// Creates a collection viewModel building an array of section with a function builder
    ///
    /// - Parameter sectionBuilder: returns an array of section
    init(@DeclarativeViewModelFonctionBuilder<Section> sectionBuilder: () -> [Section]) {
        self.sections = sectionBuilder()
    }

    /// Creates a collection viewModel building an array of section with a function builder
    /// For some unknown reason the function builder does not accept a closure returning a single cell
    /// this function provides a work around for this special case
    ///
    /// - Parameter sectionBuilder: returns a section
    init(@DeclarativeViewModelFonctionBuilder<Section> sectionBuilder: () -> Section) {
        self.sections = [sectionBuilder()]
    }
}

// MARK: - CollectionViewSectionViewModel

public extension CollectionViewSectionViewModel {
    /// Creates a section viewModel building an array of cells with a function builder
    /// the other parameters remaind unchanged from classic function declaration
    ///
    /// - Parameter id: An id for the section
    /// - Parameter supplementaryViewModels: A dictionary mapping a `SupplementaryViewSectionKey`to a `SupplementaryViewModel`
    /// - Parameter header: A `SupplementaryViewModel` for the section header
    /// - Parameter footer: A `SupplementaryViewModel` for the section footer
    /// - Parameter cellsBuilder: returns an array of cells
    init(id: String = "",
         header: SupplementaryViewModel? = nil,
         footer: SupplementaryViewModel? = nil,
         supplementaryViewModels: [SupplementaryViewSectionKey: SupplementaryViewModel] = [:],
         @DeclarativeViewModelFonctionBuilder<CellViewModel> cellsBuilder: () -> [CellViewModel]) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = cellsBuilder()
        self.supplementaryViewModels = supplementaryViewModels
    }

    /// Creates a section viewModel building an array of cells with a function builder
    /// the other parameters remaind unchanged from classic function declaration
    /// For some unknown reason the function builder does not accept a closure returning a single cell
    /// this function provides a work around for this special case
    ///
    /// - Parameter id: An id for the section
    /// - Parameter supplementaryViewModels: A dictionary mapping a `SupplementaryViewSectionKey`to a `SupplementaryViewModel`
    /// - Parameter header: A `SupplementaryViewModel` for the section header
    /// - Parameter footer: A `SupplementaryViewModel` for the section footer
    /// - Parameter cellsBuilder: returns a cell
    init(id: String = "",
         header: SupplementaryViewModel? = nil,
         footer: SupplementaryViewModel? = nil,
         supplementaryViewModels: [SupplementaryViewSectionKey: SupplementaryViewModel] = [:],
         @DeclarativeViewModelFonctionBuilder<CellViewModel> cellsBuilder: () -> CellViewModel) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = [cellsBuilder()]
        self.supplementaryViewModels = supplementaryViewModels
    }
}

// MARK: - TableViewModel

public extension TableViewModel {
    /// Creates a table viewModel building an array of sections with a function builder
    ///
    /// - Parameter sectionBuilder: returns an array of section for each entity in the `entities` array
    init(@DeclarativeViewModelFonctionBuilder<Section> sectionBuilder: () -> [Section]) {
        self.sections = sectionBuilder()
    }

    /// Creates a table viewModel building an array of sections with a function builder
    /// For some unknown reason the function builder does not accept a closure returning a single cell
    /// this function provides a work around for this special case
    ///
    /// - Parameter sectionBuilder: returns a section
    init(@DeclarativeViewModelFonctionBuilder<Section> sectionBuilder: () -> Section) {
        self.sections = [sectionBuilder()]
    }
}

// MARK: - TableViewSectionViewModel

public extension TableViewSectionViewModel {
    /// Creates a section viewModel building an array of cells with a function builder
    /// the other parameters remaind unchanged from classic function declaration
    /// For some unknown reason the function builder does not accept a closure returning a single cell
    /// this function provides a work around for this special case
    ///
    /// - Parameter id: An id for the section
    /// - Parameter header: A `SupplementaryViewModel` for the section header
    /// - Parameter footer: A `SupplementaryViewModel` for the section footer
    /// - Parameter cellsBuilder: returns an array of cells for each entity in the `entities` array
    init(id: String = "",
         header: HeaderFooterViewModel? = nil,
         footer: HeaderFooterViewModel? = nil,
         @DeclarativeViewModelFonctionBuilder<CellViewModel> cellsBuilder: () -> [CellViewModel]) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = cellsBuilder()
    }

    /// Creates a section viewModel building an array of cells with a function builder
    /// the other parameters remaind unchanged from classic function declaration
    /// For some unknown reason the function builder does not accept a closure returning a single cell
    /// this function provides a work around for this special case
    ///
    /// - Parameter id: An id for the section
    /// - Parameter header: A `SupplementaryViewModel` for the section header
    /// - Parameter footer: A `SupplementaryViewModel` for the section footer
    /// - Parameter cellsBuilder: returns a cell
    init(id: String = "",
         header: HeaderFooterViewModel? = nil,
         footer: HeaderFooterViewModel? = nil,
         @DeclarativeViewModelFonctionBuilder<CellViewModel> cellsBuilder: () -> CellViewModel) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = [cellsBuilder()]
    }
}

