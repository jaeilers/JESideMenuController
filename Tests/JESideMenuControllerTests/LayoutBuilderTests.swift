//
//  Created by Jasmin Eilers on 26.10.19.
//  Copyright © 2019 JE. All rights reserved.
//

import XCTest
@testable import JESideMenuController

@MainActor
final class LayoutBuilderTests: XCTestCase, Sendable {

    private struct Container: LayoutContainer {
        let menuContainerView = UIView()
        let containerView = UIView()
        let scrollView = UIScrollView()
        let tapView = UIView()
        let gestureContainerView = UIView()
        let shadowImageView = UIImageView()
        let darkView = UIView()
    }

    func testSlideOutBuilderLeft() {
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
        XCTAssertTrue(container.menuContainerView.superview === superview)
        XCTAssertTrue(container.scrollView.superview === superview)
        XCTAssertTrue(container.darkView.superview === superview)
        XCTAssertNotNil(container.containerView.superview)
        XCTAssertNotNil(container.tapView.superview)
        XCTAssertNotNil(container.shadowImageView.superview)
        XCTAssertNotNil(container.gestureContainerView.superview)
    }

    func testSlideOutBuilderRight() {
        // Given
        let container = Container()
        let builder = SlideOutLayoutBuilder(spacing: 0, ipadWidth: 0, container: container)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: false)

        // Then
        XCTAssertTrue(container.menuContainerView.superview === superview)
        XCTAssertTrue(container.scrollView.superview === superview)
        XCTAssertTrue(container.darkView.superview === superview)
        XCTAssertNotNil(container.containerView.superview)
        XCTAssertNotNil(container.tapView.superview)
        XCTAssertNotNil(container.shadowImageView.superview)
        XCTAssertNotNil(container.gestureContainerView.superview)
    }

    func testSlideInBuilderLeft() {
        // Given
        let container = Container()
        let builder = SlideInLayoutBuilder(spacing: 60, ipadWidth: 320, container: container)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(container.containerView.superview === superview)
        XCTAssertTrue(container.scrollView.superview === superview)
        XCTAssertTrue(container.tapView.superview === superview)
        XCTAssertTrue(container.shadowImageView.superview === superview)
        XCTAssertTrue(container.gestureContainerView.superview === superview)
        XCTAssertNotNil(container.menuContainerView.superview)
    }

    func testSlideInBuilderRight() {
        // Given
        let container = Container()
        let builder = SlideInLayoutBuilder(spacing: 60, ipadWidth: 320, container: container)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: false)

        // Then
        XCTAssertTrue(container.containerView.superview === superview)
        XCTAssertTrue(container.scrollView.superview === superview)
        XCTAssertTrue(container.tapView.superview === superview)
        XCTAssertTrue(container.shadowImageView.superview === superview)
        XCTAssertTrue(container.gestureContainerView.superview === superview)
        XCTAssertNotNil(container.menuContainerView.superview)
    }

    func testSlideOutInlineBuilderLeft() {
        // Given
        let container = Container()
        let builder = SlideOutInlineLayoutBuilder(spacing: 32, ipadWidth: 600, container: container)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(container.scrollView.superview === superview)
        XCTAssertNotNil(container.menuContainerView.superview)
        XCTAssertNotNil(container.containerView.superview)
        XCTAssertNotNil(container.tapView.superview)
        XCTAssertNotNil(container.gestureContainerView.superview)
    }

    func testSlideOutInlineBuilderRight() {
        // Given
        let container = Container()
        let builder = SlideOutInlineLayoutBuilder(spacing: 32, ipadWidth: 600, container: container)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(container.scrollView.superview === superview)
        XCTAssertNotNil(container.menuContainerView.superview)
        XCTAssertNotNil(container.containerView.superview)
        XCTAssertNotNil(container.tapView.superview)
    }

    func testDefaultLayoutBuilderDeviceSpecificConstraints() {
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
        XCTAssertEqual(scrollView.frame.width, ipadWidth)
    }

    func testDefaultLayoutBuilderScrollViewWidth() {
        // Given
        let size = CGSize(width: 320.0, height: 480.0)
        let spacing: CGFloat = 100.0
        let ipadWidth: CGFloat = 200.0
        let util = LayoutUtil(spacing: spacing, ipadWidth: ipadWidth)

        // When
        let scrollViewWidth = util.getScrollViewWidth(for: size, userInterfaceIdiom: { .phone })
        let ipadScrollViewWidth = util.getScrollViewWidth(for: size, userInterfaceIdiom: { .pad })

        // Then
        XCTAssertEqual(scrollViewWidth, size.width - spacing)
        XCTAssertEqual(ipadScrollViewWidth, ipadWidth)
    }
}
