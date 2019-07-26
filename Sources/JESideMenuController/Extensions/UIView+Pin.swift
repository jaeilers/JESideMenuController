//
//  UIView+Pin.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 01.04.19.
//

import UIKit

extension UIView {

    /**
     Pins the view to another view. The view needs to be part of the view hierarchy.
     - parameter view: The view it should be pinned to via auto layout
     */
    func pin(to view: UIView?) {
        guard superview != nil, let view = view else { return }

        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

}
