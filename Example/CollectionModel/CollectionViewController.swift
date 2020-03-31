//
//  CollectionViewController.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 27/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

typealias EmptyInitCollectionViewDataSource =
    UICollectionViewDataSource & UICollectionViewDelegate & EmptyInit & CollectionViewContent

class CollectionViewController<DataSource: EmptyInitCollectionViewDataSource>: UIViewController {

    private lazy var layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private lazy var dataSource = DataSource()

    override func loadView() {
        view = collectionView
        dataSource.register(in: collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
    }
}
