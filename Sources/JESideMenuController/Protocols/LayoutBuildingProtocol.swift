//
//  LayoutBuildingProtocol.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 03.07.19.
//

import UIKit

protocol LayoutBuilding {
    /**
     Builds the layout for a slider menu in the specified view.
     - parameter view: The entry point to build up the view hierarchy.
     - parameter isLeft: A Boolean value that determines the side which the menu will be placed.
     */
    func layout(in view: UIView?, isLeft: Bool)

    /// Adds specific constraints depending on the current device (iPhone/iPad)
    func addDeviceSpecificConstraints(to view: UIView, scrollView: UIScrollView, isLeft: Bool)
}

extension LayoutBuilding {

    func addDeviceSpecificConstraints(to view: UIView, scrollView: UIScrollView, isLeft: Bool) {
        // restrict width for ipad
        if UIDevice.current.userInterfaceIdiom == .pad {
            scrollView.widthAnchor.constraint(equalToConstant: 320.0).isActive = true
        } else if isLeft {
            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 60.0).isActive = true
        } else {
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60.0).isActive = true
        }
    }

    /// Calculate the size of the menu for a given size
    static func scrollViewWidth(for size: CGSize) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 320.0
        } else {
            return size.width - 60.0
        }
    }

}
