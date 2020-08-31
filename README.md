# CollectionModel

[![CI](https://github.com/denisPoifol/CollectionModel/workflows/CI/badge.svg)](https://github.com/denisPoifol/CollectionModel/actions?query=workflow%3ACI)
[![Version](https://img.shields.io/cocoapods/v/CollectionModel.svg?style=flat)](https://cocoapods.org/pods/CollectionModel)
[![License](https://img.shields.io/cocoapods/l/CollectionModel.svg?style=flat)](https://cocoapods.org/pods/CollectionModel)
[![Platform](https://img.shields.io/cocoapods/p/CollectionModel.svg?style=flat)](https://cocoapods.org/pods/CollectionModel)

The goal of this pod is to provide a data structure to represent what a collectionView/tableView is displaying.
It enables to extract any business logic from the dataSource of your view to the part of your code that is responsible for generating its viewModel. Which help to enforce a better separation of conrcerns within your application, and keep your dataSources easily maintanable.

## Example Application

To run the example project, clone the repo, and run `bundle install & bundle exec pod install` from the Example directory first.

## Usage

Everything is documented within Xcode. 

### TableViewModel

`TableViewModel` is a struct representing as closely as possible the structure of a `UITableView`.
It is generic over two parameters `HeaderFooterViewModel` and `CellViewModel` both parameters are self explanatory, they should represent the model used to configure the cells of the tableView or the headers and footers

This struct is mainly a wrapper for an array of `TableViewSectionViewModel` which is a struct representing a section of `UITableView`

`TableViewSectionViewModel` relies on an array of cellViewModels and two nullable header and footer properties.

Implementing a tableViewDataSource relying on tableViewModel is pretty straight forward if you only use one type of cell :
```Swift
class SimpleTableViewDataSource: NSObject,
    UITableViewDataSource {

    typealias ViewModel = TableViewModel<Never, ATableViewCellModel>

    var viewModel = ViewModel()

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ATableViewCell = tableView.dequeueCell(at: indexPath)
        cell.configure(with: viewModel[indexPath])
        return cell
    }
}
```

If you have to use multiple types of cells you should create an enum for your cells type :
```Swift
enum MultipleCellTypesTableViewCellModel {
    case a(ATableViewCellModel)
    case b(BTableViewCellModel)
}
```
This will require only to change your implementation of ``tableView(_:cellForRowAt:)`` in order to manage both cell type cases.

For more detail you can look at the example application.

### CollectionViewModel

`CollectionViewModel` is a struct representing as closely as possible the structure of a `UICollectionView`.
It is generic over two parameters `SupplementaryViewModel` and `CellViewModel` both parameters are self explanatory they should represent the models used to configure the cells of the collectionView or the supplementary views which could be a header a footer or a custom suplementary view

This struct is mainly a wrapper for an array of `CollectionSectionViewModel` which is a struct representing a section of `UICollectionView`.

`CollectionSectionViewModel` relies on an array of cellViewModels and a dictionary storing supplementaryViewModels where a key is `SupplementaryViewSectionKey` a couple of an index and kind for the suplementary view. Header and footer for the section are stored in their own variable appart from the dictionnary.

Implementing a collectionViewDataSource relying on `CollectionViewModel` is pretty straight forward if you only use one type of cell :
```Swift
class SimpleCollectionViewDataSource: NSObject,
    UICollectionViewDataSource {
	
	typealias ViewModel = CollectionViewModel<Never, CollectionViewCellModel>

    var viewModel = ViewModel()

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel[section].cells.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ACollectionViewCell = collectionView.dequeueCell(at: indexPath)
        cell.configure(with: viewModel.cellViewModel(at: indexPath))
        return cell
    }
}
```

If you have to use multiple types of cells you should create an enum for your cells type :
```Swift
enum MultipleCellTypesCollectionViewCellModel {
    case a(ACollectionViewCellModel)
    case b(BCollectionViewCellModel)
}
```
This will require only to change your implementation of `collectionView(_:cellForItemAt:)` in order to manage both cell type cases.

## Function builders

Since CollectionModelCore 0.1.1 (CollectionModel 0.2.1) it is possible to create viewModel using a declarative syntax provided by function builders. There are two different function builders you can use to create your viewModels or sections.

### Simple declarative

You can create a section or a viewModel in a declarative way :
```
Section {
    cell1
    if condition {
        [
            cell2,
            cell3,
        ]
    } else {
        cell4
    }
}
```
this implementation supports `if/else` statement which means it also supports `switch`. And as you can see from the example you can return either a cell or a collection of cells per line. Be careful though it supports any collection of cells so watch out for unordered collections.

### Entity based

Since it is not possible at the moment to support for loops in function builder, a different function builder is provided based on an iteration over an array of entities.
Most of the time your implementation is going to look like this: 
```
Section(entities: entities) { entity in
    cell1(for: entity)
}
```
But some times you might want to return multiple cells for a single entity, this is also possible.
```
Section(entities: entities) { entity in
    cell1(for: entity)
    if condition {
        [
            cell2(for: entity),
            cell3(for: entity),
        ]
    } else {
        cell(for: entity)
    }
}
```
As you can see this implementation also supports `if/else` statements and returning collections instead of single elements.

## Requirements

There is no technical requirement to use this pod other than using swift.

## Installation

CollectionModel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CollectionModel'
```

## Author

[Denis Poifol](https://twitter.com/DenisPoifol), denis.poifol@gmail.com

## License

CollectionModel is available under the MIT license. See the LICENSE file for more info.
