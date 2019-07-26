//
//  UIViewController+Containment.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 01.04.19.
//

import UIKit

extension UIViewController {

    /**
     Add a controller as child view controller and its view to a specified subview.
     - parameter controller: The new child view controller to be added
     - parameter toView: The view to which the child controller view should be added to
     */
    func add(controller: UIViewController?, toView: UIView?) {
        guard let controller = controller, let toView = toView else { return }

        addChild(controller)
        toView.addSubview(controller.view)
        controller.view.pin(to: toView)
        controller.didMove(toParent: self)
    }

    /**
     Transition from one child controller to another. The new view controller gets
     added to the specified containerView.
     - parameter fromController: The child view controller which should be removed. Can be nil.
     - parameter toController: The new child view controller wich will be added.
     - parameter containerView: The view which acts as a container for the new child controller
     - parameter duration: The duration of the transition animation. Default is 0.25.
     - parameter completion: The completion block is called after the transition is finished.
     */
    func transition(fromController: UIViewController?,
                    toViewController: UIViewController,
                    containerView: UIView?,
                    duration: TimeInterval = 0.25,
                    completion: ((_ finished: Bool) -> Void)? = nil) {
        guard fromController !== toViewController else { return }

        fromController?.willMove(toParent: nil)
        add(controller: toViewController, toView: containerView)

        // fade in the new controllers view and remove old vc
        if duration > 0.0 {
            toViewController.view.alpha = 0.0

            UIView.animate(withDuration: duration,
                           delay: 0.0,
                           options: .curveEaseInOut,
                           animations: {
                            toViewController.view.alpha = 1.0
            }, completion: { finished in
                fromController?.view.removeFromSuperview()
                fromController?.removeFromParent()
                completion?(finished)
            })
        } else {
            fromController?.view.removeFromSuperview()
            fromController?.removeFromParent()
            completion?(true)
        }
    }

    /**
     Remove a child controller.

     - parameter controller: The child view controller which should be removed.
     */
    func remove(controller: UIViewController?) {
        controller?.willMove(toParent: nil)
        controller?.view.removeFromSuperview()
        controller?.removeFromParent()
    }

}
