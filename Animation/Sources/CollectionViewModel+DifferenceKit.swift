import CollectionModelCore
import DifferenceKit

extension CollectionViewSectionViewModel: ContentEquatable {
    public func isContentEqual(to source: Self) -> Bool {
        return id.isContentEqual(to: source.id)
    }
}

extension CollectionViewSectionViewModel: ContentIdentifiable {
    public var differenceIdentifier: String {
        return id
    }
}

extension CollectionViewSectionViewModel: DifferentiableSection where
    CellViewModel: Hashable & Differentiable,
    SupplementaryViewModel: Hashable & Differentiable {
    public init<C>(source: CollectionViewSectionViewModel,
                   elements: C) where C: Swift.Collection, C.Element == CellViewModel {
        self.init(
            id: source.id,
            supplementaryViewModels: source.supplementaryViewModels,
            header: source.header,
            footer: source.footer,
            cells: elements.map { $0 }
        )
    }

    public var elements: [CellViewModel] {
        return cells
    }

    public typealias Collection = [CellViewModel]
}
