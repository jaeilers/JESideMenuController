//
//  Created by Jasmin Eilers on 01.04.19.
//  Copyright © 2019 JE. All rights reserved.
//

import Testing
import UIKit
@testable import JESideMenuController

@MainActor
@Suite
struct JESideMenuControllerTests {

    @Test
    func initialization() {
        // Given
        let rootViewController = UIViewController()
        let menuTableViewController = UITableViewController(style: .plain)
        let sideMenuController = JESideMenuController()

        // When
        sideMenuController.setMenuViewController(menuTableViewController)
        sideMenuController.setViewController(rootViewController, animated: false)

        // Then
        #expect(sideMenuController.children.count == 2)
    }

    @Test
    func storyboardInitialization() {
        // Given
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.module)

        // When
        let sideMenuController = storyboard.instantiateInitialViewController() as? JESideMenuController

        // Then
        #expect(sideMenuController != nil)
        #expect(sideMenuController?.rootId != nil)
        #expect(sideMenuController?.menuId != nil)
        sideMenuController?.loadViewIfNeeded()

        #expect(sideMenuController?.children.count == 2)
    }

    @Test
    func settingViewController() {
        // Given
        let rootViewController = UIViewController()
        let menuViewController = UITableViewController(style: .plain)

        // When
        let sideMenuController = JESideMenuController(
            menuViewController: menuViewController,
            style: .slideOutInline,
            isLeft: false
        )
        sideMenuController.setViewController(rootViewController, animated: false)
        sideMenuController.loadViewIfNeeded()

        // Then
        #expect(sideMenuController.children.count == 2)

        // Given: set view controller
        let viewController = UIViewController()

        // When
        sideMenuController.setViewController(viewController, animated: false)

        // Then
        #expect(sideMenuController.children.count == 2)
    }

    @Test
    func imageBuilder() {
        // Given
        let builder = ImageBuilder()

        // When
        let image = builder.makeShadowImage(isFadingLeft: true)

        // Then
        #expect(image != nil)
        #expect(image!.size.width == 12.0)
        #expect(image!.size.height == 3.0)

        // When
        let rightImage = builder.makeShadowImage(isFadingLeft: false)

        // Then
        #expect(rightImage != nil)
        #expect(rightImage!.size.width == 12.0)
        #expect(rightImage!.size.height == 3.0)
    }

    @Test
    func sliderPositionHiddenAtLaunch() {
        // Given
        let rootController = UIViewController()
        let menuController = UIViewController()
        let sideMenuController = JESideMenuController(
            menuViewController: menuController,
            style: .slideOut,
            isLeft: false
        )

        // When
        sideMenuController.setViewController(rootController, animated: false)
        sideMenuController.loadViewIfNeeded()
        sideMenuController.view.layoutIfNeeded()

        // Then
        #expect(!sideMenuController.isMenuVisible)
        #expect(rootController === sideMenuController.visibleViewController)

        // When: toggle the menu
        sideMenuController.toggle(animated: false)

        // Then
        #expect(sideMenuController.isMenuVisible)

        // When: Hide menu
        sideMenuController.setMenuHidden(true, animated: false)

        // Then
        #expect(!sideMenuController.isMenuVisible)
    }

    @Test
    func setViewController() {
        // Given
        let rootController = UIViewController()
        let menuController = UITableViewController(style: .plain)
        let sideMenuController = JESideMenuController(
            menuViewController: menuController,
            style: .slideOut,
            isLeft: true
        )

        // When
        sideMenuController.loadViewIfNeeded()
        sideMenuController.setViewController(rootController, animated: false)

        // Then
        #expect(sideMenuController.visibleViewController === rootController)

        // Given: set new root view controller
        let newController = UIViewController()

        // When
        sideMenuController.setViewController(newController, animated: false)

        // Then
        #expect(sideMenuController.visibleViewController === newController)
    }

    @Test
    func disableScrolling() {
        // Given
        let rootController = UIViewController()
        let menuController = UITableViewController(style: .plain)
        let sideMenuController = JESideMenuController(menuViewController: menuController)

        // When
        sideMenuController.setViewController(rootController, animated: false)
        sideMenuController.loadViewIfNeeded()

        // Then
        #expect(sideMenuController.isScrollEnabled)

        // When: Disable scrolling
        sideMenuController.isScrollEnabled = false

        #expect(!sideMenuController.isScrollEnabled)
    }
}
