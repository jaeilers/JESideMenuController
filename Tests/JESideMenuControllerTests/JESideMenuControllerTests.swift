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
        let rootViewController = UIViewController()
        let menuTableViewController = UITableViewController(style: .plain)
        let sideMenuController = JESideMenuController(rootViewController: rootViewController,
                                                      menuViewController: menuTableViewController)
        _ = sideMenuController.view
        XCTAssertEqual(sideMenuController.children.count, 2)
    }

    func testStoryboardInitialization() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: JESideMenuControllerTests.self))
        let sideMenuController = storyboard.instantiateInitialViewController() as? JESideMenuController
        XCTAssertNotNil(sideMenuController)
        XCTAssertNotNil(sideMenuController?.rootId)
        XCTAssertNotNil(sideMenuController?.menuId)
        _ = sideMenuController?.view

        XCTAssertEqual(sideMenuController?.children.count, 2)
    }

    func testSettingViewController() {
        let rootViewController = UIViewController()
        let menuViewController = UITableViewController(style: .plain)
        let sideMenuController = JESideMenuController(rootViewController: rootViewController,
                                                      menuViewController: menuViewController,
                                                      style: .slideOutInline, isLeft: false)
        _ = sideMenuController.view
        XCTAssertEqual(sideMenuController.children.count, 2)

        let viewController = UIViewController()
        sideMenuController.setViewController(viewController, animated: false)
        XCTAssertEqual(sideMenuController.children.count, 2)
    }

    func testImageBuilder() {
        let builder = ImageBuilder()
        let image = builder.shadowImage(isFadingLeft: true)
        XCTAssertNotNil(image)

        XCTAssertTrue(image!.size.width == 12.0)
        XCTAssertTrue(image!.size.height == 3.0)

        let rightImage = builder.shadowImage(isFadingLeft: false)
        XCTAssertNotNil(rightImage)

        XCTAssertTrue(rightImage!.size.width == 12.0)
        XCTAssertTrue(rightImage!.size.height == 3.0)
    }

}
