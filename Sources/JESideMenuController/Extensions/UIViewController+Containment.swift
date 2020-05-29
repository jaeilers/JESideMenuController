//
//  UIViewController+Containment.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 01.04.19.
//

import UIKit

extension UIViewController {

    /// Add a controller as child view controller and its view to a specified subview.
    /// - parameter controller: The new child view controller to be added.
    /// - parameter toView: The view to which the child controller view should be added to.
    func add(controller: UIViewController?, toView: UIView?) {
        guard let controller = controller, let toView = toView else { return }

        addChild(controller)
        toView.addSubview(controller.view)
        controller.view.pin(to: toView)
        controller.didMove(toParent: self)
    }

    /// Remove a child controller.
    /// - parameter controller: The child view controller which should be removed.
    func remove(controller: UIViewController?) {
        controller?.willMove(toParent: nil)
        controller?.view.removeFromSuperview()
        controller?.removeFromParent()
    }

}
