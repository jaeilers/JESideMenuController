//
//  LeftLayoutBuilder.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 03.07.19.
//

import UIKit

/// The `SlideOutLayoutBuilder` is responsible for setting up the layout constraints for a slide-out menu
/// on the left side.
struct SlideOutLayoutBuilder: LayoutBuilding {

    // MARK: - Protocol Properties

    let spacing: CGFloat
    let ipadWidth: CGFloat

    // MARK: - Internal Properties

    let container: LayoutContainer

    // MARK: - Internal Methods

    func layout(in view: UIView?, isLeft: Bool) {
        guard let view = view else { return }

        let contentView = UIView()
        let page = UIView()
        container.gestureContainerView.addGestureRecognizer(container.scrollView.panGestureRecognizer)

        setupSubviews(with: view, contentView: contentView, page: page)
        addDeviceSpecificConstraints(to: view, scrollView: container.scrollView, isLeft: isLeft)
        addSideSpecificConstraints(to: view, contentView: contentView, page: page, isLeft: isLeft)
        addConstraints(to: view, contentView: contentView, page: page)
    }

    // MARK: - Private Methods

    /// Add all views to the view hierarchy.
    /// - Parameters:
    ///   - view: The superview.
    ///   - contentView: The contentView of the scrollView.
    ///   - page: A view that acts as a spacer for the containerView to reveal the menu underneath.
    @MainActor private func setupSubviews(with view: UIView, contentView: UIView, page: UIView) {
        view.addSubview(container.scrollView)
        view.addSubview(container.menuContainerView)
        view.addSubview(container.darkView)

        container.gestureContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container.gestureContainerView)

        container.gestureContainerView.addSubview(container.shadowImageView)
        container.gestureContainerView.addSubview(container.containerView)
        container.gestureContainerView.addSubview(container.tapView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        container.scrollView.addSubview(contentView)

        page.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(page)
    }

    /// Adds constraints that are specific for the side where the menu should be placed (left/right).
    /// - Parameters:
    ///   - view: The superview.
    ///   - contentView: The contentView of the scrollView.
    ///   - page: A view that acts as a spacer for the containerView to reveal the menu underneath.
    ///   - isLeft: A Boolean value that determines on which side the menu should be placed in the layout.
    @MainActor private func addSideSpecificConstraints(
        to view: UIView,
        contentView: UIView,
        page: UIView,
        isLeft: Bool
    ) {
        if isLeft {
            NSLayoutConstraint.activate([
                container.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                page.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                container.gestureContainerView.leadingAnchor.constraint(equalTo: page.leadingAnchor),
                container.menuContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                container.menuContainerView.trailingAnchor.constraint(equalTo: container.scrollView.trailingAnchor),
                container.shadowImageView.trailingAnchor.constraint(equalTo: container.containerView.leadingAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                container.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                page.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                container.gestureContainerView.trailingAnchor.constraint(equalTo: page.trailingAnchor),
                container.menuContainerView.leadingAnchor.constraint(equalTo: container.scrollView.leadingAnchor),
                container.menuContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                container.shadowImageView.leadingAnchor.constraint(equalTo: container.containerView.trailingAnchor)
            ])
        }
    }

    /// Adds all the remaining constraints that aren't device or side specific to all the views.
    /// All views have to be added in the view hierarchy beforehand.
    /// - Parameters:
    ///   - view: The superview.
    ///   - contentView: The contentView of the scrollView.
    ///   - page: A view that acts as a spacer for the containerView to reveal the menu underneath.
    ///   - gestureContainerView: A view that hosts the scrollViews gesture recognizer.
    @MainActor private func addConstraints(to view: UIView, contentView: UIView, page: UIView) {
        NSLayoutConstraint.activate([
            container.scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            container.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: container.scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: container.scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: container.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: container.scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: container.scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: container.scrollView.widthAnchor, multiplier: 2.0),
            page.topAnchor.constraint(equalTo: contentView.topAnchor),
            page.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            page.widthAnchor.constraint(equalTo: container.scrollView.widthAnchor),
            container.gestureContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            container.gestureContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.gestureContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.shadowImageView.topAnchor.constraint(equalTo: container.gestureContainerView.topAnchor),
            container.shadowImageView.bottomAnchor.constraint(equalTo: container.gestureContainerView.bottomAnchor),
            container.containerView.leadingAnchor.constraint(equalTo: container.gestureContainerView.leadingAnchor),
            container.containerView.topAnchor.constraint(equalTo: container.gestureContainerView.topAnchor),
            container.containerView.trailingAnchor.constraint(equalTo: container.gestureContainerView.trailingAnchor),
            container.containerView.bottomAnchor.constraint(equalTo: container.gestureContainerView.bottomAnchor),
            container.menuContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            container.menuContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.tapView.leadingAnchor.constraint(equalTo: container.gestureContainerView.leadingAnchor),
            container.tapView.topAnchor.constraint(equalTo: container.gestureContainerView.topAnchor),
            container.tapView.trailingAnchor.constraint(equalTo: container.gestureContainerView.trailingAnchor),
            container.tapView.bottomAnchor.constraint(equalTo: container.gestureContainerView.bottomAnchor),
            container.darkView.leadingAnchor.constraint(equalTo: container.menuContainerView.leadingAnchor),
            container.darkView.topAnchor.constraint(equalTo: container.menuContainerView.topAnchor),
            container.darkView.trailingAnchor.constraint(equalTo: container.menuContainerView.trailingAnchor),
            container.darkView.bottomAnchor.constraint(equalTo: container.menuContainerView.bottomAnchor)
        ])
    }
}
