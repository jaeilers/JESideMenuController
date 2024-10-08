//
//  Created by Jasmin Eilers on 01.04.19.
//

import UIKit

public final class JESideMenuController: UIViewController, LayoutContainer {

    private struct Constants: Sendable {
        static let alpha: CGFloat = 0.15
    }

    /// Constants for the side menu controller layout styles.
    public enum Style: Int, Sendable {
        /// A classic slide-out style where the main view slides out to reveal the menu underneath.
        case slideOut
        /// The menu slides in and overlays the main view.
        case slideIn
        /// A slide-out style similar to twitter. The menu appears to be on the same level as the main view
        /// and pushes the main view out.
        case slideOutInline
    }

    // MARK: - Public Properties

    /// The `rootId` is the storyboard id of the root view controller.
    @IBInspectable public var rootId: String?

    /// The `menuId` is the storyboard id of the menu view controller.
    @IBInspectable public var menuId: String?

    /// Set the style of layout.
    @IBInspectable public var layoutStyle: Int = 0 {
        didSet {
            style = Style(rawValue: layoutStyle) ?? .slideOut
        }
    }

    /// A Boolean value that determines on which side the menu will be placed.
    @IBInspectable public var isLeft: Bool = true

    /// The currently visible, hosted view controller.
    public var visibleViewController: UIViewController? {
        rootViewController
    }

    /// A Boolean value that indicates if the side menu is displayed on screen.
    public var isMenuVisible: Bool {
        isLeft ? scrollView.contentOffset.x <= 0 : scrollView.contentOffset.x >= scrollView.bounds.width
    }

    /// A Boolean value that indicates whether scrolling is enabled.
    public var isScrollEnabled: Bool {
        get { scrollView.isScrollEnabled }
        set {
            scrollView.isScrollEnabled = newValue
            // hide the gesture container view for slide-in style, so that it doesn't block swipe-back.
            guard style == .slideIn else { return }
            gestureContainerView.isHidden = !newValue
        }
    }

    // MARK: - Layout Container Properties

    /// The containerView for the content.
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// The containerView for the menu.
    lazy var menuContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// Responsible for the scrolling behavior of the menu (paging).
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isHidden = true
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        return scrollView
    }()

    /// Hosts the tap gesture recognizer to close the menu.
    lazy var tapView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    /// Drop down shadow.
    lazy var shadowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.isHidden = true
        return imageView
    }()

    /// Darkens the menu in .slideOut to reveal it underneath the containerView
    lazy var darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = configuration.tintColor
        return view
    }()

    /// View that hosts the gesture recognizer for the slide-in menu.
    lazy var gestureContainerView = UIView()

    // MARK: - Private Properties

    private weak var menuViewController: UIViewController?
    private weak var rootViewController: UIViewController?

    private var style: Style = .slideOut
    private var configuration: Configuration = .default
    private var isLaunch = true

    // MARK: - Init

    /// Initializes the side menu controller with general settings.
    /// - Parameters:
    ///   - menuViewController: The controller that should be displayed and act as the menu.
    ///   - style: Set the style of the layout. Default is a slide-out style.
    ///   - isLeft: A Boolean value that determines on which side the menu will be placed. Default is `true`.
    ///   - configuration: The configuration specifies the layout for example spacing and drop shadow visibility.
    public init(
        menuViewController: UIViewController? = nil,
        style: Style = .slideOut,
        isLeft: Bool = true,
        configuration: Configuration = .default
    ) {
        super.init(nibName: nil, bundle: nil)
        self.style = style
        self.isLeft = isLeft
        self.configuration = configuration

        guard let menuViewController = menuViewController else { return }
        add(controller: menuViewController, toView: menuContainerView)
        self.menuViewController = menuViewController
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - ViewController Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()

        initializeRootFromStoryboard()
        initializeMenuFromStoryboard()
        setupView()
    }

    // MARK: - ViewController Lifecycle

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideMenuAtLaunch()
    }

    /// Forward TraitCollection change to the childViewController
    override public func willTransition(
        to newCollection: UITraitCollection,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.willTransition(to: newCollection, with: coordinator)
        rootViewController?.willTransition(to: newCollection, with: coordinator)
        menuViewController?.willTransition(to: newCollection, with: coordinator)
    }

    /// Determine whether the menu is open or closed and set the content offset of the scrollView,
    /// so that the status of the menu (open/closed) doesn't change on rotation.
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let offsetX = scrollView.contentOffset.x
        let util = LayoutUtil(spacing: configuration.spacing, ipadWidth: configuration.ipadWidth)
        let scrollViewWidth: CGFloat = util.getScrollViewWidth(for: size)

        coordinator.animate(alongsideTransition: { [unowned self] _ in
            self.scrollView.contentOffset.x = offsetX > 0.0 ? scrollViewWidth : 0.0
        })
        super.viewWillTransition(to: size, with: coordinator)
    }

    // MARK: - Public Methods

    /// Set the view controller that should act as the menu.
    /// - Parameters:
    ///   - viewController: The view controller that will be displayed as the menu.
    public func setMenuViewController(_ viewController: UIViewController) {
        remove(controller: menuViewController)
        add(controller: viewController, toView: menuContainerView)
        menuViewController = viewController
    }

    /// Set and display a new root view controller and hides the slider menu with an animation.
    /// - Parameters:
    ///   - viewController: The view controller which will be displayed.
    ///   - animated: A boolean value that indicates whether the menu is hidden with an animation. Default is `true`.
    public func setViewController(
        _ viewController: UIViewController,
        animated: Bool = true
    ) {
        setMenuHidden(true, animated: animated)

        guard rootViewController !== viewController else { return }
        remove(controller: rootViewController)
        add(controller: viewController, toView: containerView)
        rootViewController = viewController
    }

    /// Hides or reveals the menu based on the current state.
    /// - Parameters:
    ///   - animated: A Boolean value that determines if the change should be animated. Default is `true`.
    public func toggle(animated: Bool = true) {
        let offsetX: CGFloat = scrollView.contentOffset.x > 0 ? 0.0 : scrollView.bounds.width
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0.0), animated: animated)
    }

    /// Set the hidden state of the menu. Optionally animated.
    /// - Parameters:
    ///   - isHidden: A Boolean value that determines whether the menu view controller will be hidden.
    ///   - animated: A Boolean value that determines if the change should be animated.
    public func setMenuHidden(_ isHidden: Bool, animated: Bool) {
        let leftOffset: CGFloat = isHidden ? scrollView.bounds.width : 0.0
        let rightOffset: CGFloat = isHidden ? 0.0 : scrollView.bounds.width
        let offsetX: CGFloat = isLeft ? leftOffset : rightOffset
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0.0), animated: animated)
    }

    // MARK: - Private Methods

    /// Only initializes the root view controller if it's set via storyboard.
    private func initializeRootFromStoryboard() {
        guard let rootId = rootId else { return }
        rootViewController = storyboard?.instantiateViewController(withIdentifier: rootId)

        guard let rootViewController = rootViewController else { return }
        add(controller: rootViewController, toView: containerView)
    }

    /// Only initializes the menu view controller if it's set via storyboard.
    private func initializeMenuFromStoryboard() {
        guard let menuId = menuId else { return }
        menuViewController = storyboard?.instantiateViewController(withIdentifier: menuId)

        guard let menuViewController = menuViewController else { return }
        add(controller: menuViewController, toView: menuContainerView)
    }

    private func hideMenuAtLaunch() {
        guard isLaunch else { return }
        isLaunch = false
        let offsetX: CGFloat = isLeft ? scrollView.bounds.width : 0.0
        scrollView.contentOffset.x = offsetX
    }

    /// Close the menu
    @objc private func tapToClose(_ sender: UITapGestureRecognizer) {
        setMenuHidden(true, animated: true)
    }
}

// MARK: - Layout Setup

extension JESideMenuController {

    /// Set-up the layout depending on the side (left/right) and style.
    private func setupView() {
        let imageBuilder = ImageBuilder()
        let builder: LayoutBuilding
        let image: UIImage?

        switch style {
        case .slideOut:
            image = imageBuilder.makeShadowImage(isFadingLeft: isLeft)
            builder = SlideOutLayoutBuilder(spacing: configuration.spacing, ipadWidth: configuration.ipadWidth,
                                            container: self)
        case .slideIn:
            image = imageBuilder.makeShadowImage(isFadingLeft: !isLeft)
            tapView.backgroundColor = configuration.tintColor
            builder = SlideInLayoutBuilder(spacing: configuration.spacing, ipadWidth: configuration.ipadWidth,
                                           container: self)
        case .slideOutInline:
            image = nil
            tapView.backgroundColor = configuration.tintColor
            builder = SlideOutInlineLayoutBuilder(spacing: configuration.spacing, ipadWidth: configuration.ipadWidth,
                                                  container: self)
        }

        builder.layout(in: view, isLeft: isLeft)

        if configuration.hasDropShadowImage {
            shadowImageView.image = configuration.dropShadowImage == nil ? image : configuration.dropShadowImage
            shadowImageView.tintColor = configuration.tintColor
        } else {
            shadowImageView.removeFromSuperview()
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToClose(_:)))
        tapView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - ScrollView Delegate

extension JESideMenuController: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // calculate the alpha for the tapView to darken the content and recognize the tap gesture
        let alpha = getAlpha(for: isLeft, maxValue: Constants.alpha, scrollView: scrollView)
        tapView.isHidden = alpha == 0.0
        tapView.alpha = alpha

        menuContainerView.isHidden = alpha == 0.0
        shadowImageView.isHidden = alpha == 0.0

        // this view is only present in the .slideOut style to reveal/lighten the menu when it opens
        guard style == .slideOut else { return }
        let darkAlpha = getAlpha(for: !isLeft, maxValue: Constants.alpha, scrollView: scrollView)
        darkView.alpha = darkAlpha
        darkView.isHidden = darkAlpha == 0.0
    }

    // Calculates the alpha value for the views
    private func getAlpha(for isLeft: Bool, maxValue: CGFloat, scrollView: UIScrollView) -> CGFloat {
        guard scrollView.bounds.width > 0 else { return 0.0 }
        if isLeft {
            return -((maxValue / scrollView.bounds.width) * scrollView.contentOffset.x) + maxValue
        } else {
            return maxValue / scrollView.bounds.width * scrollView.contentOffset.x
        }
    }
}
