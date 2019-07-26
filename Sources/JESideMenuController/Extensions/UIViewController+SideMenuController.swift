//
//  UIViewController+SideMenuController.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 01.04.19.
//

import UIKit

public extension UIViewController {

    /// Find the current `SideMenuController` instance.
    var sideMenuController: JESideMenuController? {
        var parent = self.parent

        while parent != nil {
            if let sideMenuController = parent as? JESideMenuController {
                return sideMenuController
            }
            parent = parent?.parent
        }
        return nil
    }

}
