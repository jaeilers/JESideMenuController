//
//  Created by Jasmin Eilers on 01.04.19.
//  Copyright © 2019 JE. All rights reserved.
//

import Testing
import UIKit
@testable import JESideMenuController

@MainActor
@Suite
struct UIViewControllerExtensionTests {

    @Test
    func sideMenuControllerExtension() {
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
        #expect(viewController.sideMenuController != nil)
        #expect(rootViewController.sideMenuController != nil)
        #expect(menuViewController.sideMenuController != nil)

        #expect(sideMenuController.sideMenuController == nil)
    }

    @Test
    func containment() {
        let parent = UIViewController()
        let viewController = UIViewController()
        #expect(parent.children.count == 0)

        parent.add(controller: viewController, toView: parent.view)
        #expect(parent.children.count == 1)

        parent.remove(controller: viewController)
        #expect(parent.children.count == 0)
    }
}
