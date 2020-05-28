//
//  LeftSlideInLayoutBuilder.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 04.07.19.
//

import UIKit

/**
 The `SlideInLayoutBuilder` is a slide-in menu similar to a navigation drawer that slides in over the content.
 This layout builder layouts the menu on specific side (left/right).
 */
struct SlideInLayoutBuilder: LayoutBuilding {

    // MARK: - Protocol Properties

    let spacing: CGFloat
    let ipadWidth: CGFloat

    // MARK: - Internal Properties

    /// A containerView that hosts the content of the menu.
    let menuContainerView: UIView
    /// A containerView that hosts the general content.
    let containerView: UIView
    /// A scrollView that handles the paging behaviour to hide/reveal the menu.
    let scrollView: UIScrollView
    /// A view that recognizes a tap to close the menu gesture.
    let tapView: UIView
    /// A view that recognizes the pan gesture of the scrollView at the screen edge.
    let gestureContainerView: UIView
    /// An image view with a drop shadow.
    let imageView: UIImageView

    // MARK: - Internal Methods

    func layout(in view: UIView?, isLeft: Bool) {
        guard let view = view else { return }

        let contentView = UIView()
        gestureContainerView.addGestureRecognizer(scrollView.panGestureRecognizer)

        setupSubviews(with: view, contentView: contentView)
        addDeviceSpecificConstraints(to: view, scrollView: scrollView, isLeft: isLeft)
        addSideSpecificConstraints(with: view, contentView: contentView, isLeft: isLeft)
        addConstraints(with: view, contentView: contentView)
    }

    // MARK: - Private Methods

    /**
     Add all views to the view hierarchy.
     - parameter view: The superview.
     - parameter contentView: The contentView of the scrollView.
     */
    private func setupSubviews(with view: UIView, contentView: UIView) {
        view.addSubview(scrollView)
        view.addSubview(containerView)
        view.addSubview(imageView)
        view.addSubview(gestureContainerView)
        view.addSubview(tapView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        gestureContainerView.translatesAutoresizingMaskIntoConstraints = false
        gestureContainerView.addSubview(menuContainerView)
    }

    /**
     Adds constraints that are specific for the side where the menu should be placed (left/right).
     - parameter view: The superview.
     - parameter contentView: The contentView of the scrollView.
     - parameter isLeft: A Boolean value that determines on which side menu should be placed in the layout.
     */
    private func addSideSpecificConstraints(with view: UIView, contentView: UIView, isLeft: Bool) {
        if isLeft {
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                gestureContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                menuContainerView.leadingAnchor.constraint(equalTo: gestureContainerView.leadingAnchor),
                imageView.leadingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
                tapView.leadingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
                tapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
        } else {
            NSLayoutConstraint.activate([
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                gestureContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                menuContainerView.trailingAnchor.constraint(equalTo: gestureContainerView.trailingAnchor),
                imageView.trailingAnchor.constraint(equalTo: menuContainerView.leadingAnchor),
                tapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tapView.trailingAnchor.constraint(equalTo: menuContainerView.leadingAnchor)
                ])
        }
    }

    /**
     Adds all the remaining constraints that aren't device or side specific to all the views.
     All views have to be added in the view hierarchy beforehand.
     - parameter view: The superview.
     - parameter contentView: The contentView of the scrollView.
     */
    private func addConstraints(with view: UIView, contentView: UIView) {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 2.0),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gestureContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            gestureContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 20.0),
            gestureContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            menuContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tapView.topAnchor.constraint(equalTo: view.topAnchor),
            tapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

}
