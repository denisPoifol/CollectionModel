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

/// This conformance allows for DifferenceKit to create StagedChangeSet which in turn enable to animate changes.
/// If you find yourself unable to create a changeSet using StagedChangeSet(source:,target:) with you ViewModel
/// you should check on the conditions which are that your CellViewModel conforms to Hashable and Differentiable
/// and the same goes for your SupplementaryViewModel.
/// Note that Never conformance to Hashable is handled by Swift and conformance to Differentiable is handled
/// by this pod.
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
