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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSlideOutBuilderLeft() {
        // Given
        let menuContainerView = UIView()
        let containerView = UIView()
        let scrollView = UIScrollView()
        let tapView = UIView()
        let imageView = UIImageView()
        let darkView = UIView()
        let builder = SlideOutLayoutBuilder(menuContainerView: menuContainerView,
                                            containerView: containerView,
                                            scrollView: scrollView,
                                            tapView: tapView,
                                            imageView: imageView,
                                            darkView: darkView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(menuContainerView.superview === superview)
        XCTAssertTrue(scrollView.superview === superview)
        XCTAssertTrue(darkView.superview === superview)
        XCTAssertNotNil(containerView.superview)
        XCTAssertNotNil(tapView.superview)
        XCTAssertNotNil(imageView.superview)
    }

    func testSlideOutBuilderRight() {
        // Given
        let menuContainerView = UIView()
        let containerView = UIView()
        let scrollView = UIScrollView()
        let tapView = UIView()
        let imageView = UIImageView()
        let darkView = UIView()
        let builder = SlideOutLayoutBuilder(menuContainerView: menuContainerView,
                                            containerView: containerView,
                                            scrollView: scrollView,
                                            tapView: tapView,
                                            imageView: imageView,
                                            darkView: darkView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: false)

        // Then
        XCTAssertTrue(menuContainerView.superview === superview)
        XCTAssertTrue(scrollView.superview === superview)
        XCTAssertTrue(darkView.superview === superview)
        XCTAssertNotNil(containerView.superview)
        XCTAssertNotNil(tapView.superview)
        XCTAssertNotNil(imageView.superview)
    }

    func testSlideInBuilderLeft() {
        // Given
        let menuContainerView = UIView()
        let containerView = UIView()
        let scrollView = UIScrollView()
        let tapView = UIView()
        let imageView = UIImageView()
        let builder = SlideInLayoutBuilder(menuContainerView: menuContainerView,
                                           containerView: containerView,
                                           scrollView: scrollView,
                                           tapView: tapView,
                                           imageView: imageView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(containerView.superview === superview)
        XCTAssertTrue(scrollView.superview === superview)
        XCTAssertTrue(tapView.superview === superview)
        XCTAssertTrue(imageView.superview === superview)
        XCTAssertNotNil(menuContainerView.superview)
    }

    func testSlideInBuilderRight() {
        // Given
        let menuContainerView = UIView()
        let containerView = UIView()
        let scrollView = UIScrollView()
        let tapView = UIView()
        let imageView = UIImageView()
        let builder = SlideInLayoutBuilder(menuContainerView: menuContainerView,
                                           containerView: containerView,
                                           scrollView: scrollView,
                                           tapView: tapView,
                                           imageView: imageView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: false)

        // Then
        XCTAssertTrue(containerView.superview === superview)
        XCTAssertTrue(scrollView.superview === superview)
        XCTAssertTrue(tapView.superview === superview)
        XCTAssertTrue(imageView.superview === superview)
        XCTAssertNotNil(menuContainerView.superview)
    }

    func testSlideOutInlineBuilderLeft() {
        // Given
        let menuContainerView = UIView()
        let containerView = UIView()
        let scrollView = UIScrollView()
        let tapView = UIView()
        let builder = SlideOutInlineLayoutBuilder(menuContainerView: menuContainerView,
                                                  containerView: containerView,
                                                  scrollView: scrollView,
                                                  tapView: tapView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(scrollView.superview === superview)
        XCTAssertNotNil(menuContainerView.superview)
        XCTAssertNotNil(containerView.superview)
        XCTAssertNotNil(tapView.superview)
    }

    func testSlideOutInlineBuilderRight() {
        // Given
        let menuContainerView = UIView()
        let containerView = UIView()
        let scrollView = UIScrollView()
        let tapView = UIView()
        let builder = SlideOutInlineLayoutBuilder(menuContainerView: menuContainerView,
                                                  containerView: containerView,
                                                  scrollView: scrollView,
                                                  tapView: tapView)

        // When
        let superview = UIView()
        builder.layout(in: superview, isLeft: true)

        // Then
        XCTAssertTrue(scrollView.superview === superview)
        XCTAssertNotNil(menuContainerView.superview)
        XCTAssertNotNil(containerView.superview)
        XCTAssertNotNil(tapView.superview)
    }

}
