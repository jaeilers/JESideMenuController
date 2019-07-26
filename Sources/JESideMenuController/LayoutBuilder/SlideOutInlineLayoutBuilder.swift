//
//  SlideOutInlineLayoutBuilder.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 06.07.19.
//

import UIKit

/**
 The `SlideOutInlineLayoutBuilder` is responsible for building a layout where menu and the content slide-out
 simultaniously.
 */
struct SlideOutInlineLayoutBuilder: LayoutBuilding {

    // MARK: - Internal Properties

    /// A containerView that hosts the content of the menu.
    let menuContainerView: UIView
    /// A containerView that hosts the general content.
    let containerView: UIView
    /// A scrollView that handles the paging behaviour to hide/reveal the menu.
    let scrollView: UIScrollView
    /// A view that recognizes a tap to close the menu gesture.
    let tapView: UIView

    // MARK: - Internal Methods

    func layout(in view: UIView?, isLeft: Bool) {
        guard let view = view else { return }

        let contentView = UIView()
        let gestureContainerView = UIView()
        gestureContainerView.addGestureRecognizer(scrollView.panGestureRecognizer)

        setupSubviews(with: view, contentView: contentView, gestureContainerView: gestureContainerView)
        addDeviceSpecificConstraints(to: view, scrollView: scrollView, isLeft: isLeft)
        addSideSpecificConstraints(with: view, contentView: contentView, gestureContainerView: gestureContainerView,
                                   isLeft: isLeft)
        addConstraints(with: view, contentView: contentView, gestureContainerView: gestureContainerView)
    }

    // MARK: - Private Methods

    /**
     Add all views to the view hierarchy.
     - parameter view: The superview.
     - parameter contentView: The contentView of the scrollView.
     - parameter gestureContainerView: A container that wraps the menu and the containerView.
     This view is responsible recognizing the scrollViews pan gesture.
     */
    private func setupSubviews(with view: UIView, contentView: UIView, gestureContainerView: UIView) {
        view.addSubview(scrollView)
        view.addSubview(gestureContainerView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        gestureContainerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        gestureContainerView.addSubview(menuContainerView)
        gestureContainerView.addSubview(containerView)
        gestureContainerView.addSubview(tapView)
    }

    /**
     Adds constraints that are specific for the side where the menu should be placed (left/right).
     - parameter view: The superview.
     - parameter contentView: The contentView of the scrollView.
     - parameter gestureContainerView: A container that wraps the menu and the containerView.
     This view is responsible for recognizing the scrollViews pan gesture.
     - parameter isLeft: A Boolean value that determines on which side menu should be placed in the layout.
     */
    private func addSideSpecificConstraints(with view: UIView, contentView: UIView, gestureContainerView: UIView,
                                            isLeft: Bool) {
        if isLeft {
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                menuContainerView.leadingAnchor.constraint(equalTo: gestureContainerView.leadingAnchor),
                containerView.leadingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
                containerView.trailingAnchor.constraint(equalTo: gestureContainerView.trailingAnchor),
                gestureContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
                ])
        } else {
            NSLayoutConstraint.activate([
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                menuContainerView.trailingAnchor.constraint(equalTo: gestureContainerView.trailingAnchor),
                containerView.trailingAnchor.constraint(equalTo: menuContainerView.leadingAnchor),
                containerView.leadingAnchor.constraint(equalTo: gestureContainerView.leadingAnchor),
                gestureContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                ])
        }
    }

    /**
     Adds all the remaining constraints that aren't device or side specific to all the views.
     All views have to be added in the view hierarchy beforehand.
     - parameter view: The superview.
     - parameter contentView: The contentView of the scrollView.
     - parameter gestureContainerView: A container that wraps the menu and the containerView.
     This view is responsible for recognizing the scrollViews pan gesture.
     */
    private func addConstraints(with view: UIView, contentView: UIView, gestureContainerView: UIView) {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 2.0),
            gestureContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            gestureContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuContainerView.topAnchor.constraint(equalTo: gestureContainerView.topAnchor),
            menuContainerView.bottomAnchor.constraint(equalTo: gestureContainerView.bottomAnchor),
            menuContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.topAnchor.constraint(equalTo: gestureContainerView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: gestureContainerView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tapView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tapView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tapView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tapView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
    }

}
