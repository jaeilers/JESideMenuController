//
//  MenuTableViewController.swift
//  SideMenuControllerExample
//
//  Created by Jasmin Eilers on 14.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

import UIKit
import JESideMenuController

class MenuTableViewController: UIViewController {

    private struct Constants {
        static let identifier = "cell"
    }

    private struct Item {
        let image: UIImage
        let title: String
        let storyboardID: String
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let menuItems = [ Item(image: #imageLiteral(resourceName: "comment"), title: "Home", storyboardID: "root"),
                              Item(image: #imageLiteral(resourceName: "home"), title: "Profile", storyboardID: "table"),
                              Item(image: #imageLiteral(resourceName: "settings"), title: "Settings", storyboardID: "settings")]
    private var cache = NSCache<NSString, UIViewController>()

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        cacheRootViewController()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44.0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])

        tableView.tableFooterView = UIView()
    }

    // Cache the view controllers
    private func viewController(with identifier: String) -> UIViewController? {
        if let viewController = cache.object(forKey: identifier as NSString) {
            return viewController
        } else if let viewController = storyboard?.instantiateViewController(withIdentifier: identifier) {
            cache.setObject(viewController, forKey: identifier as NSString)
            return viewController
        } else {
            return nil
        }
    }

    // An example to access the currently visible view controller and cache it.
    private func cacheRootViewController() {
        guard let visibleViewController = sideMenuController?.visibleViewController else { return }
        cache.setObject(visibleViewController, forKey: (menuItems.first?.storyboardID ?? "") as NSString)
    }

}

// MARK: - Table view dataSource

extension MenuTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath)

        let item = menuItems[indexPath.row]
        cell.imageView?.image = item.image
        cell.textLabel?.text = item.title

        return cell
    }

}

// MARK: - Table view delegate

extension MenuTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = menuItems[indexPath.row]
        guard let viewController = viewController(with: item.storyboardID) else { return }
        sideMenuController?.setViewController(viewController)
    }

}
