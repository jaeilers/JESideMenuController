//
//  Created by Jasmin Eilers on 20.02.21.
//

import UIKit

@MainActor
protocol LayoutContainer: Sendable {
    /// The main container view to host the content.
    var containerView: UIView { get }
    /// The container view for the menu (viewController).
    var menuContainerView: UIView { get }
    /// The paging scrollView.
    var scrollView: UIScrollView { get }
    /// The view that hosts the tap gesture to close the menu.
    var tapView: UIView { get }
    /// A drop shadow image (depends on the layout style).
    var shadowImageView: UIImageView { get }
    /// A view that visually darkens the content or menu (depends on the layout style).
    var darkView: UIView { get }
    /// A view that hosts the gesture recognizer of the scrollView.
    var gestureContainerView: UIView { get }
}
