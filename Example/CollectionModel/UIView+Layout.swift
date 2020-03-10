//
//  UIView+Layout.swift
//  CollectionModel_Example
//
//  Created by Denis Poifol on 28/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    @discardableResult
    func pinToSuperview(edges: UIRectEdge = .all,
                        insets: UIEdgeInsets = .zero,
                        priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        guard let superview = self.superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            edges.contains(.top) ? pinTo(view: superview, attribute: .top, constant: insets.top, priority: priority) : nil,
            edges.contains(.left) ? pinTo(view: superview, attribute: .left, constant: insets.left, priority: priority) : nil,
            edges.contains(.bottom) ? pinTo(view: superview, attribute: .bottom, constant: -insets.bottom, priority: priority) : nil,
            edges.contains(.right) ? pinTo(view: superview, attribute: .right, constant: -insets.right, priority: priority) : nil,
            ].compactMap { $0 }
        return constraints
    }


    private func pinTo(view: UIView,
                       attribute: NSLayoutConstraint.Attribute,
                       constant: CGFloat,
                       priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .equal,
            toItem: view,
            attribute: attribute,
            multiplier: 1.0,
            constant: constant
        )
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}
