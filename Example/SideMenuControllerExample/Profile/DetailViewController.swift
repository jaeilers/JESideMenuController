//
//  DetailViewController.swift
//  SideMenuControllerExample
//
//  Created by Jasmin Eilers on 03.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

import UIKit
import JESideMenuController

/// An example to disable the scrolling in detail views.
class DetailViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        sideMenuController?.isScrollEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sideMenuController?.isScrollEnabled = true
    }

}
