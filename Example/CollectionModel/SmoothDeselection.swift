//
//  SmoothDeselection.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func smoothlyDeselectItems(in coordinator: UIViewControllerTransitionCoordinator?) {
        guard let selectedIndexPaths = indexPathsForSelectedRows else { return }
        guard let coordinator = coordinator else {
            selectedIndexPaths.forEach {
                deselectRow(at: $0, animated: false)
            }
            return
        }

        coordinator.animateAlongsideTransition(
            in: self,
            animation: { [weak self] (context: UIViewControllerTransitionCoordinatorContext) in
                selectedIndexPaths.forEach {
                    self?.deselectRow(at: $0, animated: true)
                }
            },
            completion: { [weak self] (context: UIViewControllerTransitionCoordinatorContext) in
                guard context.isCancelled else {
                    return
                }
                selectedIndexPaths.forEach {
                    self?.selectRow(at: $0, animated: false, scrollPosition: .none)
                }
            }
        )
    }
}
