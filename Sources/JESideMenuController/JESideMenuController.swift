//
//  JESideMenuController.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 01.04.19.
//

import UIKit

public class JESideMenuController: UIViewController {

    private struct Constants {
        static let alpha: CGFloat = 0.15
    }

    /// Constants for the side menu controller layout styles.
    public enum Style: Int {
        case slideOut, slideIn, slideOutInline
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

    public var visibleViewController: UIViewController? {
        return rootViewController
    }

    /// A Boolean value that indicates if the side menu is displayed on screen.
    public var isMenuVisible: Bool {
        return isLeft ? scrollView.contentOffset.x <= 0 : scrollView.contentOffset.x >= scrollView.bounds.width
    }

    /// A Boolean value that indicates whether scrolling is enabled.
    public var isScrollEnabled: Bool {
        set { scrollView.isScrollEnabled = newValue }
        get { return scrollView.isScrollEnabled }
    }

    // MARK: - Private Properties

    /// The containerView for the content.
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// The containerView for the menu.
    private lazy var menuContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// Responsible for the scrolling behaviour of the menu (paging).
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isHidden = true
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        return scrollView
    }()

    /// Hosts the tap gesture recognizer to close the menu.
    private lazy var tapView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    /// Drop down shadow
    private lazy var shadowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.isHidden = true
        return imageView
    }()

    /// Darkens the menu in .slideOut to reveal it underneath the containerView
    private lazy var darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        return view
    }()

    private weak var menuViewController: UIViewController?
    private weak var rootViewController: UIViewController?

    private var style: Style = .slideOut
    private var isLaunch = true

    // MARK: - Init

    /**
     Initializes the side menu controller with a menu view controller and a root view controller which will
     is displayed as first view.
     - parameter rootViewController: The first view controller. This is typically the home screen.
     - parameter menuViewController: The menu view controller controls the initialization of controllers.
     - parameter isLeft: A Boolean value that determines on which side the menu will be placed.
     - parameter style: Set the style of the layout. Default is a slide-out style.
     */
    public init(rootViewController: UIViewController, menuViewController: UIViewController, style: Style = .slideOut,
                isLeft: Bool = true) {
        super.init(nibName: nil, bundle: nil)
        self.menuViewController = menuViewController
        self.rootViewController = rootViewController
        self.isLeft = isLeft
        self.style = style

        add(controller: rootViewController, toView: containerView)
        add(controller: menuViewController, toView: menuContainerView)
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

        // hide the menu at launch
        if isLaunch {
            isLaunch = false

            let offsetX = isLeft ? scrollView.bounds.width : 0.0
            scrollView.contentOffset.x = offsetX
        }
    }

    // Forward TraitCollection change to the childViewController
    override public func willTransition(to newCollection: UITraitCollection,
                                        with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        rootViewController?.willTransition(to: newCollection, with: coordinator)
        menuViewController?.willTransition(to: newCollection, with: coordinator)
    }

    /*
     Determine whether the menu is open or closed and set the content offset of the scrollView,
     so that the status of the menu (open/closed) doesn't change on rotation.
     */
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let offsetX = scrollView.contentOffset.x

        coordinator.animate(alongsideTransition: { [unowned self] _ in
            self.scrollView.contentOffset.x = offsetX > 0.0 ? SlideOutLayoutBuilder.scrollViewWidth(for: size) : 0.0
        })
        super.viewWillTransition(to: size, with: coordinator)
    }

    // MARK: - Public Methods

    /**
     Set and display a new root view controller. If animated is set to `true`, the slider will automatically hide.
     - parameter viewController: The view controller which will be displayed.
     - parameter animated: The slider will automatically hide, if the boolean value is `true`.
     - parameter completion: The completion block is called after the animation finished.
     */
    public func setViewController(_ viewController: UIViewController,
                                  animated: Bool) {
        transition(fromController: rootViewController,
                   toViewController: viewController,
                   containerView: containerView,
                   duration: 0.0, completion: { _ in
            self.rootViewController = viewController
        })

        setMenuHidden(true, animated: animated)
    }

    /**
     Hides or reveals the menu based on the current state.
     - parameter animated: A Boolean value that determines if the change should be animated. Default is `true`.
     */
    public func toggle(animated: Bool = true) {
        let offsetX = scrollView.contentOffset.x > 0 ? 0.0 : scrollView.bounds.width
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0.0), animated: animated)
    }

    /**
     Set the hidden state of the menu. Optionally animated.
     - parameter isHidden: A Boolean value that determines whether the menu view controller will be hidden.
     - parameter animated: A Boolean value that determines if the change should be animated.
     */
    public func setMenuHidden(_ isHidden: Bool, animated: Bool) {
        let leftOffset = isHidden ? scrollView.bounds.width : 0.0
        let rightOffset = isHidden ? 0.0 : scrollView.bounds.width
        let offsetX = isLeft ? leftOffset : rightOffset
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
            image = imageBuilder.shadowImage(isFadingLeft: isLeft)
            builder = SlideOutLayoutBuilder(menuContainerView: menuContainerView, containerView: containerView,
                                            scrollView: scrollView, tapView: tapView, imageView: shadowImageView,
                                            darkView: darkView)
        case .slideIn:
            image = imageBuilder.shadowImage(isFadingLeft: !isLeft)
            tapView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            builder = SlideInLayoutBuilder(menuContainerView: menuContainerView, containerView: containerView,
                                           scrollView: scrollView, tapView: tapView, imageView: shadowImageView)
        case .slideOutInline:
            image = nil
            tapView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            builder = SlideOutInlineLayoutBuilder(menuContainerView: menuContainerView, containerView: containerView,
                                                  scrollView: scrollView, tapView: tapView)
        }
        builder.layout(in: view, isLeft: isLeft)
        shadowImageView.image = image

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
        guard style == .slideOut else {
            return
        }
        let darkAlpha = getAlpha(for: !isLeft, maxValue: Constants.alpha, scrollView: scrollView)
        darkView.alpha = darkAlpha
        darkView.isHidden = darkAlpha == 0.0
    }

    // Calculates the alpha value for the views
    private func getAlpha(for isLeft: Bool, maxValue: CGFloat, scrollView: UIScrollView) -> CGFloat {
        if isLeft {
            return -((maxValue / scrollView.bounds.width) * scrollView.contentOffset.x) + maxValue
        } else {
            return maxValue / scrollView.bounds.width * scrollView.contentOffset.x
        }
    }

}
