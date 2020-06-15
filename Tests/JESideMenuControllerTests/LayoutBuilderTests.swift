//
//  LayoutBuilderTests.swift
//  JESideMenuControllerTests
//
//  Created by Jasmin Eilers on 26.10.19.
//  Copyright © 2019 JE. All rights reserved.
//

import XCTest
@testable import JESideMenuController

class LayoutBuilderTests: XCTestCase {

    private struct Layout {
        let menuContainerView = UIView()
        let containerView = UIView()
        let scrollView = UIScrollView()
        let tapView = UIView()
        let gestureContainerView = UIView()
        let imageView = UIImageView()
        let darkView = UIView()
    }

    func testSlideOutBuilderLeft() {
        // Given
        let layout = Layout()
        let builder = SlideOutLayoutBuilder(spacing: 60, ipadWidth: 320,
                                            menuContainerView: layout.menuContainerView,
                                            containerView: layout.containerView,
                                            scrollView: layout.scrollView,
                                            tapView: layout.tapView,
                                            imageView: layout.imageView,
                                            darkView: layout.darkView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(layout.menuContainerView.superview === superview)
        XCTAssertTrue(layout.scrollView.superview === superview)
        XCTAssertTrue(layout.darkView.superview === superview)
        XCTAssertNotNil(layout.containerView.superview)
        XCTAssertNotNil(layout.tapView.superview)
        XCTAssertNotNil(layout.imageView.superview)
    }

    func testSlideOutBuilderRight() {
        // Given
        let layout = Layout()
        let builder = SlideOutLayoutBuilder(spacing: 0, ipadWidth: 0,
                                            menuContainerView: layout.menuContainerView,
                                            containerView: layout.containerView,
                                            scrollView: layout.scrollView,
                                            tapView: layout.tapView,
                                            imageView: layout.imageView,
                                            darkView: layout.darkView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: false)

        // Then
        XCTAssertTrue(layout.menuContainerView.superview === superview)
        XCTAssertTrue(layout.scrollView.superview === superview)
        XCTAssertTrue(layout.darkView.superview === superview)
        XCTAssertNotNil(layout.containerView.superview)
        XCTAssertNotNil(layout.tapView.superview)
        XCTAssertNotNil(layout.imageView.superview)
    }

    func testSlideInBuilderLeft() {
        // Given
        let layout = Layout()
        let builder = SlideInLayoutBuilder(spacing: 60, ipadWidth: 320,
                                           menuContainerView: layout.menuContainerView,
                                           containerView: layout.containerView,
                                           scrollView: layout.scrollView,
                                           tapView: layout.tapView,
                                           gestureContainerView: layout.gestureContainerView,
                                           imageView: layout.imageView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(layout.containerView.superview === superview)
        XCTAssertTrue(layout.scrollView.superview === superview)
        XCTAssertTrue(layout.tapView.superview === superview)
        XCTAssertTrue(layout.imageView.superview === superview)
        XCTAssertTrue(layout.gestureContainerView.superview === superview)
        XCTAssertNotNil(layout.menuContainerView.superview)
    }

    func testSlideInBuilderRight() {
        // Given
        let layout = Layout()
        let builder = SlideInLayoutBuilder(spacing: 60, ipadWidth: 320,
                                           menuContainerView: layout.menuContainerView,
                                           containerView: layout.containerView,
                                           scrollView: layout.scrollView,
                                           tapView: layout.tapView,
                                           gestureContainerView: layout.gestureContainerView,
                                           imageView: layout.imageView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: false)

        // Then
        XCTAssertTrue(layout.containerView.superview === superview)
        XCTAssertTrue(layout.scrollView.superview === superview)
        XCTAssertTrue(layout.tapView.superview === superview)
        XCTAssertTrue(layout.imageView.superview === superview)
        XCTAssertTrue(layout.gestureContainerView.superview === superview)
        XCTAssertNotNil(layout.menuContainerView.superview)
    }

    func testSlideOutInlineBuilderLeft() {
        // Given
        let layout = Layout()
        let builder = SlideOutInlineLayoutBuilder(spacing: 32, ipadWidth: 600,
                                                  menuContainerView: layout.menuContainerView,
                                                  containerView: layout.containerView,
                                                  scrollView: layout.scrollView,
                                                  tapView: layout.tapView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(layout.scrollView.superview === superview)
        XCTAssertNotNil(layout.menuContainerView.superview)
        XCTAssertNotNil(layout.containerView.superview)
        XCTAssertNotNil(layout.tapView.superview)
    }

    func testSlideOutInlineBuilderRight() {
        // Given
        let layout = Layout()
        let builder = SlideOutInlineLayoutBuilder(spacing: 32, ipadWidth: 600,
                                                  menuContainerView: layout.menuContainerView,
                                                  containerView: layout.containerView,
                                                  scrollView: layout.scrollView,
                                                  tapView: layout.tapView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(layout.scrollView.superview === superview)
        XCTAssertNotNil(layout.menuContainerView.superview)
        XCTAssertNotNil(layout.containerView.superview)
        XCTAssertNotNil(layout.tapView.superview)
    }

    func testDefaultLayoutBuilderDeviceSpecificConstraints() {
        // Given
        let spacing: CGFloat = 50.0
        let ipadWidth: CGFloat = 200.0
        let builder = DefaultLayoutBuilder(spacing: spacing, ipadWidth: ipadWidth)

        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(scrollView)
        containerView.addSubview(view)

        // When
        builder.addDeviceSpecificConstraints(to: view, scrollView: scrollView, isLeft: true, userInterfaceIdiom: .pad)
        scrollView.layoutIfNeeded()

        // Then
        XCTAssertEqual(scrollView.frame.width, ipadWidth)
    }

    func testDefaultLayoutBuilderScrollViewWidth() {
        // Given
        let size = CGSize(width: 320.0, height: 480.0)
        let spacing: CGFloat = 100.0
        let ipadWidth: CGFloat = 200.0
        let builder = DefaultLayoutBuilder(spacing: spacing, ipadWidth: ipadWidth)

        // When
        let scrollViewWidth = builder.getScrollViewWidth(for: size, userInterfaceIdiom: .phone)
        let ipadScrollViewWidth = builder.getScrollViewWidth(for: size, userInterfaceIdiom: .pad)

        // Then
        XCTAssertEqual(scrollViewWidth, size.width - spacing)
        XCTAssertEqual(ipadScrollViewWidth, ipadWidth)
    }

}
