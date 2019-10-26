//
//  JESideMenuControllerTests.swift
//  JESideMenuControllerTests
//
//  Created by Jasmin Eilers on 01.04.19.
//  Copyright © 2019 JE. All rights reserved.
//

import XCTest
@testable import JESideMenuController

class JESideMenuControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialization() {
        // Given
        let rootViewController = UIViewController()
        let menuTableViewController = UITableViewController(style: .plain)
        let sideMenuController = JESideMenuController(rootViewController: rootViewController,
                                                      menuViewController: menuTableViewController)
        // When
        _ = sideMenuController.view

        // Then
        XCTAssertEqual(sideMenuController.children.count, 2)
    }

    func testStoryboardInitialization() {
        // Given
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: JESideMenuControllerTests.self))

        // When
        let sideMenuController = storyboard.instantiateInitialViewController() as? JESideMenuController

        // Then
        XCTAssertNotNil(sideMenuController)
        XCTAssertNotNil(sideMenuController?.rootId)
        XCTAssertNotNil(sideMenuController?.menuId)
        _ = sideMenuController?.view

        XCTAssertEqual(sideMenuController?.children.count, 2)
    }

    func testSettingViewController() {
        // Given
        let rootViewController = UIViewController()
        let menuViewController = UITableViewController(style: .plain)

        // When
        let sideMenuController = JESideMenuController(rootViewController: rootViewController,
                                                      menuViewController: menuViewController,
                                                      style: .slideOutInline, isLeft: false)
        _ = sideMenuController.view

        // Then
        XCTAssertEqual(sideMenuController.children.count, 2)

        // Given: set view controller
        let viewController = UIViewController()

        // When
        sideMenuController.setViewController(viewController, animated: false)

        // Then
        XCTAssertEqual(sideMenuController.children.count, 2)
    }

    func testImageBuilder() {
        // Given
        let builder = ImageBuilder()

        // When
        let image = builder.shadowImage(isFadingLeft: true)

        // Then
        XCTAssertNotNil(image)
        XCTAssertTrue(image!.size.width == 12.0)
        XCTAssertTrue(image!.size.height == 3.0)

        // When
        let rightImage = builder.shadowImage(isFadingLeft: false)

        // Then
        XCTAssertNotNil(rightImage)
        XCTAssertTrue(rightImage!.size.width == 12.0)
        XCTAssertTrue(rightImage!.size.height == 3.0)
    }

    func testSliderPositionHiddenAtLaunch() {
        // Given
        let rootController = UIViewController()
        let menuController = UITableViewController(style: .grouped)

        let sideMenuController = JESideMenuController(rootViewController: rootController,
                                                      menuViewController: menuController,
                                                      style: .slideOut,
                                                      isLeft: false)
        // When
        _ = sideMenuController.view
        sideMenuController.view.layoutIfNeeded()

        // Then
        XCTAssertFalse(sideMenuController.isMenuVisible)
        XCTAssertTrue(rootController === sideMenuController.visibleViewController)

        // When: toggle the menu
        sideMenuController.toggle(animated: false)

        // Then
        XCTAssertTrue(sideMenuController.isMenuVisible)

        // When: Hide menu
        sideMenuController.setMenuHidden(true, animated: false)

        // Then
        XCTAssertFalse(sideMenuController.isMenuVisible)
    }

    func testSetViewController() {
        // Given
        let rootController = UIViewController()
        let menuController = UITableViewController(style: .plain)
        let sideMenuController = JESideMenuController(rootViewController: rootController,
                                                      menuViewController: menuController,
                                                      style: .slideOut,
                                                      isLeft: true)

        // When
        _ = sideMenuController.view

        // Then
        XCTAssertTrue(sideMenuController.visibleViewController === rootController)

        // Given: set new root view controller
        let newController = UIViewController()

        // When
        sideMenuController.setViewController(newController, animated: false)

        // Then
        XCTAssertTrue(sideMenuController.visibleViewController === newController)
    }

    func testDisableScrolling() {
        // Given
        let rootController = UIViewController()
        let menuController = UITableViewController(style: .plain)
        let sideMenuController = JESideMenuController(rootViewController: rootController,
                                                      menuViewController: menuController)

        // When
        _ = sideMenuController.view

        // Then
        XCTAssertTrue(sideMenuController.isScrollEnabled)

        // When: Disable scrolling
        sideMenuController.isScrollEnabled = false

        XCTAssertFalse(sideMenuController.isScrollEnabled)
    }

}
