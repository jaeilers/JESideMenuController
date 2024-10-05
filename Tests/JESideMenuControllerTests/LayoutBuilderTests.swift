//
//  Created by Jasmin Eilers on 26.10.19.
//  Copyright © 2019 JE. All rights reserved.
//

import Testing
import UIKit
@testable import JESideMenuController

@MainActor
@Suite
struct LayoutBuilderTests {

    private struct Container: LayoutContainer {
        let menuContainerView = UIView()
        let containerView = UIView()
        let scrollView = UIScrollView()
        let tapView = UIView()
        let gestureContainerView = UIView()
        let shadowImageView = UIImageView()
        let darkView = UIView()
    }

    @Test
    func slideOutBuilderLeft() {
        // Given
        let container = Container()
        let builder = SlideOutLayoutBuilder(
            spacing: 60,
            ipadWidth: 320,
            container: container
        )

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        #expect(container.menuContainerView.superview === superview)
        #expect(container.scrollView.superview === superview)
        #expect(container.darkView.superview === superview)
        #expect(container.containerView.superview != nil)
        #expect(container.tapView.superview != nil)
        #expect(container.shadowImageView.superview != nil)
        #expect(container.gestureContainerView.superview != nil)
    }

    @Test
    func slideOutBuilderRight() {
        // Given
        let container = Container()
        let builder = SlideOutLayoutBuilder(spacing: 0, ipadWidth: 0, container: container)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: false)

        // Then
        #expect(container.menuContainerView.superview === superview)
        #expect(container.scrollView.superview === superview)
        #expect(container.darkView.superview === superview)
        #expect(container.containerView.superview != nil)
        #expect(container.tapView.superview != nil)
        #expect(container.shadowImageView.superview != nil)
        #expect(container.gestureContainerView.superview != nil)
    }

    @Test
    func slideInBuilderLeft() {
        // Given
        let container = Container()
        let builder = SlideInLayoutBuilder(spacing: 60, ipadWidth: 320, container: container)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        #expect(container.containerView.superview === superview)
        #expect(container.scrollView.superview === superview)
        #expect(container.tapView.superview === superview)
        #expect(container.shadowImageView.superview === superview)
        #expect(container.gestureContainerView.superview === superview)
        #expect(container.menuContainerView.superview != nil)
    }

    @Test
    func slideInBuilderRight() {
        // Given
        let container = Container()
        let builder = SlideInLayoutBuilder(spacing: 60, ipadWidth: 320, container: container)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: false)

        // Then
        #expect(container.containerView.superview === superview)
        #expect(container.scrollView.superview === superview)
        #expect(container.tapView.superview === superview)
        #expect(container.shadowImageView.superview === superview)
        #expect(container.gestureContainerView.superview === superview)
        #expect(container.menuContainerView.superview != nil)
    }

    @Test
    func slideOutInlineBuilderLeft() {
        // Given
        let container = Container()
        let builder = SlideOutInlineLayoutBuilder(spacing: 32, ipadWidth: 600, container: container)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        #expect(container.scrollView.superview === superview)
        #expect(container.menuContainerView.superview != nil)
        #expect(container.containerView.superview != nil)
        #expect(container.tapView.superview != nil)
        #expect(container.gestureContainerView.superview != nil)
    }

    @Test
    func slideOutInlineBuilderRight() {
        // Given
        let container = Container()
        let builder = SlideOutInlineLayoutBuilder(spacing: 32, ipadWidth: 600, container: container)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        #expect(container.scrollView.superview === superview)
        #expect(container.menuContainerView.superview != nil)
        #expect(container.containerView.superview != nil)
        #expect(container.tapView.superview != nil)
    }

    @Test
    func defaultLayoutBuilderDeviceSpecificConstraints() {
        // Given
        let spacing: CGFloat = 50.0
        let ipadWidth: CGFloat = 200.0
        let util = LayoutUtil(spacing: spacing, ipadWidth: ipadWidth)

        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(scrollView)
        containerView.addSubview(view)

        // When
        util.addDeviceSpecificConstraints(to: view, scrollView: scrollView, isLeft: true, userInterfaceIdiom: { .pad })
        scrollView.layoutIfNeeded()

        // Then
        #expect(scrollView.frame.width == ipadWidth)
    }

    @Test
    func defaultLayoutBuilderScrollViewWidth() {
        // Given
        let size = CGSize(width: 320.0, height: 480.0)
        let spacing: CGFloat = 100.0
        let ipadWidth: CGFloat = 200.0
        let util = LayoutUtil(spacing: spacing, ipadWidth: ipadWidth)

        // When
        let scrollViewWidth = util.getScrollViewWidth(for: size, userInterfaceIdiom: { .phone })
        let ipadScrollViewWidth = util.getScrollViewWidth(for: size, userInterfaceIdiom: { .pad })

        // Then
        #expect(scrollViewWidth == size.width - spacing)
        #expect(ipadScrollViewWidth == ipadWidth)
    }
}
