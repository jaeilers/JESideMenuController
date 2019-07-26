//
//  LeftLayoutBuilder.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 03.07.19.
//

import UIKit

/**
 The `SlideOutLayoutBuilder` is responsible for setting up the layout constraints for a slide-out menu on the left side.
 */
struct SlideOutLayoutBuilder: LayoutBuilding {

    // MARK: - Internal Properties

    /// A containerView that hosts the content of the menu.
    let menuContainerView: UIView
    /// A containerView that hosts the general content.
    let containerView: UIView
    /// A scrollView that handles the paging behaviour to hide/reveal the menu.
    let scrollView: UIScrollView
    /// A view that recognizes a tap to close the menu gesture.
    let tapView: UIView
    /// An image view with a drop shadow.
    let imageView: UIImageView
    /// A view that darkens the menu at the beginning of animation, to reveal the menu underneath
    let darkView: UIView

    // MARK: - Internal Methods

    func layout(in view: UIView?, isLeft: Bool) {
        guard let view = view else { return }

        let contentView = UIView()
        let page = UIView()
        let gestureContainerView = UIView()
        gestureContainerView.addGestureRecognizer(scrollView.panGestureRecognizer)

        setupSubviews(with: view, contentView: contentView, page: page, gestureContainerView: gestureContainerView)
        addDeviceSpecificConstraints(to: view, scrollView: scrollView, isLeft: isLeft)
        addSideSpecificConstraints(to: view, contentView: contentView, page: page,
                                   gestureContainerView: gestureContainerView, isLeft: isLeft)
        addConstraints(to: view, contentView: contentView, page: page, gestureContainerView: gestureContainerView)
    }

    // MARK: - Private Methods

    /**
     Add all views to the view hierarchy.
     - parameter view: The superview.
     - parameter contentView: The contentView of the scrollView.
     - parameter page: A view that acts as a spacer for the containerView to reveal the menu underneath.
     */
    private func setupSubviews(with view: UIView, contentView: UIView, page: UIView, gestureContainerView: UIView) {
        view.addSubview(scrollView)
        view.addSubview(menuContainerView)
        view.addSubview(darkView)

        gestureContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gestureContainerView)

        gestureContainerView.addSubview(imageView)
        gestureContainerView.addSubview(containerView)
        gestureContainerView.addSubview(tapView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        page.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(page)
    }

    /**
     Adds constraints that are specific for the side where the menu should be placed (left/right).
     - parameter view: The superview.
     - parameter contentView: The contentView of the scrollView.
     - parameter page: A view that acts as a spacer for the containerView to reveal the menu underneath.
     - parameter isLeft: A Boolean value that determines on which side the menu should be placed in the layout.
     */
    private func addSideSpecificConstraints(to view: UIView, contentView: UIView, page: UIView,
                                            gestureContainerView: UIView, isLeft: Bool) {
        if isLeft {
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                page.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                gestureContainerView.leadingAnchor.constraint(equalTo: page.leadingAnchor),
                menuContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                menuContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                imageView.trailingAnchor.constraint(equalTo: containerView.leadingAnchor)
                ])
        } else {
            NSLayoutConstraint.activate([
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                page.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                gestureContainerView.trailingAnchor.constraint(equalTo: page.trailingAnchor),
                menuContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                menuContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.leadingAnchor.constraint(equalTo: containerView.trailingAnchor)
                ])
        }
    }

    /**
     Adds all the remaining constraints that aren't device or side specific to all the views.
     All views have to be added in the view hierarchy beforehand.
     - parameter view: The superview.
     - parameter contentView: The contentView of the scrollView.
     - parameter page: A view that acts as a spacer for the containerView to reveal the menu underneath.
     */
    private func addConstraints(to view: UIView, contentView: UIView, page: UIView, gestureContainerView: UIView) {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 2.0),
            page.topAnchor.constraint(equalTo: contentView.topAnchor),
            page.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            page.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            gestureContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            gestureContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gestureContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.topAnchor.constraint(equalTo: gestureContainerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: gestureContainerView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: gestureContainerView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: gestureContainerView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: gestureContainerView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: gestureContainerView.bottomAnchor),
            menuContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            menuContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tapView.leadingAnchor.constraint(equalTo: gestureContainerView.leadingAnchor),
            tapView.topAnchor.constraint(equalTo: gestureContainerView.topAnchor),
            tapView.trailingAnchor.constraint(equalTo: gestureContainerView.trailingAnchor),
            tapView.bottomAnchor.constraint(equalTo: gestureContainerView.bottomAnchor),
            darkView.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor),
            darkView.topAnchor.constraint(equalTo: menuContainerView.topAnchor),
            darkView.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
            darkView.bottomAnchor.constraint(equalTo: menuContainerView.bottomAnchor)
            ])
    }

}
