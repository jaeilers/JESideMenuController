//
//  LayoutBuildingProtocol.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 03.07.19.
//

import UIKit

protocol LayoutBuilding {

    /// Visible spacing of the content view if the menu is open
    var spacing: CGFloat { get }

    /// Menu width on iPad
    var ipadWidth: CGFloat { get }

    /**
     Builds the layout for a slider menu in the specified view.
     - parameter view: The entry point to build up the view hierarchy.
     - parameter isLeft: A Boolean value that determines the side which the menu will be placed.
     */
    func layout(in view: UIView?, isLeft: Bool)

}

extension LayoutBuilding {

    /// Adds specific constraints depending on the current device (iPhone/iPad)
    func addDeviceSpecificConstraints(to view: UIView, scrollView: UIScrollView, isLeft: Bool,
                                      userInterfaceIdiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom) {
        // restrict width for ipad
        if userInterfaceIdiom == .pad {
            scrollView.widthAnchor.constraint(equalToConstant: ipadWidth).isActive = true
        } else if isLeft {
            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: spacing).isActive = true
        } else {
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing).isActive = true
        }
    }

    /// Calculates the width of the scroll view based on a given size and the current devide (iPhone/iPad)
    func getScrollViewWidth(for size: CGSize,
                            userInterfaceIdiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom) -> CGFloat {
        if userInterfaceIdiom == .pad {
            return ipadWidth
        } else {
            return size.width - spacing
        }
    }

}

// Enable testing for `getScrollViewWidth(for:, userInterfaceIdiom:)`
struct DefaultLayoutBuilder: LayoutBuilding {
    var spacing: CGFloat
    var ipadWidth: CGFloat

    func layout(in view: UIView?, isLeft: Bool) {}
}
