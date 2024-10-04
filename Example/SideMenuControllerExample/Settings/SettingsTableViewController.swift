//
//  SettingsTableViewController.swift
//  SideMenuControllerExample
//
//  Created by JE on 17.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

import UIKit
import JESideMenuController

// An example for more control over the menus visibility.
final class SettingsTableViewController: UITableViewController {

    @IBAction private func toggle(_ sender: UIBarButtonItem) {
        // get the current visibility state via the `isMenuVisible` property
        if sideMenuController?.isMenuVisible ?? false {
            // show/hide the menu directly via `setMenuHidden(_:, animated:)`
            sideMenuController?.setMenuHidden(true, animated: true)
        } else {
            sideMenuController?.setMenuHidden(false, animated: true)
        }
    }
}
