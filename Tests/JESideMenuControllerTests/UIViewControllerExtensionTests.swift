//
//  UIViewControllerExtensionTests.swift
//  JESideMenuControllerTests
//
//  Created by Jasmin Eilers on 01.04.19.
//  Copyright © 2019 JE. All rights reserved.
//

import XCTest
@testable import JESideMenuController

class UIViewControllerExtensionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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

        parent.transition(fromController: nil,
                          toViewController: viewcontroller,
                          containerView: parent.view,
                          duration: 0.0)
        XCTAssertEqual(parent.children.count, 1)

        let expectation = XCTestExpectation(description: "Transition with animation")
        let viewcontroller2 = UIViewController()

        parent.transition(fromController: viewcontroller,
                          toViewController: viewcontroller2,
                          containerView: parent.view,
                          duration: 0.05, completion: { _ in
                            XCTAssertEqual(parent.children.count, 1)
                            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2.0)
    }

}
