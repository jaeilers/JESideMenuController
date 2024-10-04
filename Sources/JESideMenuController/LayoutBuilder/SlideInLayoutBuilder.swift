//
//  LeftSlideInLayoutBuilder.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 04.07.19.
//

import UIKit

/// The `SlideInLayoutBuilder` is a slide-in menu similar to a navigation drawer that slides in over the content.
/// This layout builder layouts the menu on specific side (left/right).
struct SlideInLayoutBuilder: LayoutBuilding {

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
        view.addSubview(container.containerView)
        view.addSubview(container.shadowImageView)
        view.addSubview(container.gestureContainerView)
        view.addSubview(container.tapView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        container.scrollView.addSubview(contentView)

        container.gestureContainerView.translatesAutoresizingMaskIntoConstraints = false
        container.gestureContainerView.addSubview(container.menuContainerView)
    }

    /// Adds constraints that are specific for the side where the menu should be placed (left/right).
    /// - parameter view: The superview.
    /// - parameter contentView: The contentView of the scrollView.
    /// - parameter isLeft: A Boolean value that determines on which side menu should be placed in the layout.
    @MainActor private func addSideSpecificConstraints(with view: UIView, contentView: UIView, isLeft: Bool) {
        if isLeft {
            NSLayoutConstraint.activate([
                container.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                container.gestureContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                container.menuContainerView.leadingAnchor.constraint(
                    equalTo: container.gestureContainerView.leadingAnchor
                ),
                container.shadowImageView.leadingAnchor.constraint(equalTo: container.menuContainerView.trailingAnchor),
                container.tapView.leadingAnchor.constraint(equalTo: container.menuContainerView.trailingAnchor),
                container.tapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        } else {
            // the layout system might break this constraint on rotation.
            let tapLeading = container.tapView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            tapLeading.priority = .defaultHigh
            tapLeading.isActive = true

            NSLayoutConstraint.activate([
                container.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                container.gestureContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                container.menuContainerView.trailingAnchor.constraint(
                    equalTo: container.gestureContainerView.trailingAnchor
                ),
                container.shadowImageView.trailingAnchor.constraint(equalTo: container.menuContainerView.leadingAnchor),
                container.tapView.trailingAnchor.constraint(equalTo: container.menuContainerView.leadingAnchor)
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
            container.containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.containerView.topAnchor.constraint(equalTo: view.topAnchor),
            container.containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.gestureContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            container.gestureContainerView.widthAnchor.constraint(
                equalTo: container.scrollView.widthAnchor,
                constant: 20.0
            ),
            container.gestureContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.shadowImageView.topAnchor.constraint(equalTo: view.topAnchor),
            container.shadowImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.menuContainerView.topAnchor.constraint(equalTo: container.gestureContainerView.topAnchor),
            container.menuContainerView.bottomAnchor.constraint(equalTo: container.gestureContainerView.bottomAnchor),
            container.menuContainerView.widthAnchor.constraint(equalTo: container.scrollView.widthAnchor),
            container.tapView.topAnchor.constraint(equalTo: view.topAnchor),
            container.tapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
