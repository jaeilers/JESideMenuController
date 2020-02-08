//
//  ProfileTableViewController.swift
//  SideMenuControllerExample
//
//  Created by Jasmin Eilers on 14.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

import UIKit
import JESideMenuController

class ProfileTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 42
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1)
        return cell
    }

    // An example for the toggle functionality
    @IBAction private func toggle(_ sender: UIButton) {
        sideMenuController?.toggle()
    }

}
