//
//  UIViewControllerExtensionTests.swift
//  JESideMenuControllerTests
//
//  Created by Jasmin Eilers on 01.04.19.
//  Copyright © 2019 JE. All rights reserved.
//

import XCTest
@testable import JESideMenuController

@MainActor
final class UIViewControllerExtensionTests: XCTestCase {

    func testSideMenuControllerExtension() {
        // Given
        let rootViewController = UIViewController()
        let menuViewController = UIViewController()
        let sideMenuController = JESideMenuController(menuViewController: menuViewController)
        sideMenuController.setViewController(rootViewController, animated: false)
        let tabBarController = UITabBarController()
        let viewController = UIViewController()

        // When
        rootViewController.addChild(tabBarController)
        tabBarController.didMove(toParent: rootViewController)
        tabBarController.setViewControllers([viewController], animated: false)

        // Then
        XCTAssertNotNil(viewController.sideMenuController)
        XCTAssertNotNil(rootViewController.sideMenuController)
        XCTAssertNotNil(menuViewController.sideMenuController)

        XCTAssertNil(sideMenuController.sideMenuController)
    }

    func testContainment() {
        let parent = UIViewController()
        let viewcontroller = UIViewController()
        XCTAssertEqual(parent.children.count, 0)

        parent.add(controller: viewcontroller, toView: parent.view)
        XCTAssertEqual(parent.children.count, 1)

        parent.remove(controller: viewcontroller)
        XCTAssertEqual(parent.children.count, 0)
    }
}
