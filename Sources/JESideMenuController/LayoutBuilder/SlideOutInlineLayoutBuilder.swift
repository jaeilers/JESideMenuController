//
//  SlideOutInlineLayoutBuilder.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 06.07.19.
//

import UIKit

/// The `SlideOutInlineLayoutBuilder` is responsible for building a layout where menu and the content slide-out
/// simultaneously.
struct SlideOutInlineLayoutBuilder: LayoutBuilding {

    // MARK: - Protocol Properties

    let spacing: CGFloat
    let ipadWidth: CGFloat

    // MARK: - Internal Properties

    let container: LayoutContainer

    // MARK: - Internal Methods

    func layout(in view: UIView?, isLeft: Bool) {
        guard let view = view else { return }

        let contentView = UIView()
        container.gestureContainerView.addGestureRecognizer(container.scrollView.panGestureRecognizer)

        setupSubviews(with: view, contentView: contentView)
        addDeviceSpecificConstraints(to: view, scrollView: container.scrollView, isLeft: isLeft)
        addSideSpecificConstraints(with: view, contentView: contentView, isLeft: isLeft)
        addConstraints(with: view, contentView: contentView)
    }

    // MARK: - Private Methods

    /// Add all views to the view hierarchy.
    /// - parameter view: The superview.
    /// - parameter contentView: The contentView of the scrollView.
    @MainActor private func setupSubviews(with view: UIView, contentView: UIView) {
        view.addSubview(container.scrollView)
        view.addSubview(container.gestureContainerView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        container.gestureContainerView.translatesAutoresizingMaskIntoConstraints = false
        container.scrollView.addSubview(contentView)
        container.gestureContainerView.addSubview(container.menuContainerView)
        container.gestureContainerView.addSubview(container.containerView)
        container.gestureContainerView.addSubview(container.tapView)
    }

    /// Adds constraints that are specific for the side where the menu should be placed (left/right).
    /// - parameter view: The superview.
    /// - parameter contentView: The contentView of the scrollView.
    /// - parameter isLeft: A Boolean value that determines on which side menu should be placed in the layout.
    @MainActor private func addSideSpecificConstraints(with view: UIView, contentView: UIView, isLeft: Bool) {
        if isLeft {
            NSLayoutConstraint.activate([
                container.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                container.menuContainerView.leadingAnchor.constraint(
                    equalTo: container.gestureContainerView.leadingAnchor
                ),
                container.containerView.leadingAnchor.constraint(equalTo: container.menuContainerView.trailingAnchor),
                container.containerView.trailingAnchor.constraint(
                    equalTo: container.gestureContainerView.trailingAnchor),
                container.gestureContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                container.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                container.menuContainerView.trailingAnchor.constraint(
                    equalTo: container.gestureContainerView.trailingAnchor
                ),
                container.containerView.trailingAnchor.constraint(equalTo: container.menuContainerView.leadingAnchor),
                container.containerView.leadingAnchor.constraint(equalTo: container.gestureContainerView.leadingAnchor),
                container.gestureContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
    }

    /// Adds all the remaining constraints that aren't device or side specific to all the views.
    /// All views have to be added in the view hierarchy beforehand.
    /// - parameter view: The superview.
    /// - parameter contentView: The contentView of the scrollView.
    @MainActor private func addConstraints(with view: UIView, contentView: UIView) {
        NSLayoutConstraint.activate([
            container.scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            container.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: container.scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: container.scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: container.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: container.scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: container.scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: container.scrollView.widthAnchor, multiplier: 2.0),
            container.gestureContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            container.gestureContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.menuContainerView.topAnchor.constraint(equalTo: container.gestureContainerView.topAnchor),
            container.menuContainerView.bottomAnchor.constraint(equalTo: container.gestureContainerView.bottomAnchor),
            container.menuContainerView.widthAnchor.constraint(equalTo: container.scrollView.widthAnchor),
            container.containerView.topAnchor.constraint(equalTo: container.gestureContainerView.topAnchor),
            container.containerView.bottomAnchor.constraint(equalTo: container.gestureContainerView.bottomAnchor),
            container.containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.tapView.leadingAnchor.constraint(equalTo: container.containerView.leadingAnchor),
            container.tapView.topAnchor.constraint(equalTo: container.containerView.topAnchor),
            container.tapView.trailingAnchor.constraint(equalTo: container.containerView.trailingAnchor),
            container.tapView.bottomAnchor.constraint(equalTo: container.containerView.bottomAnchor)
        ])
    }
}
