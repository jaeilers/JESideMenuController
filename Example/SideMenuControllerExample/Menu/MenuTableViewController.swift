//
//  MenuTableViewController.swift
//  SideMenuControllerExample
//
//  Created by JE on 14.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

import UIKit
import JESideMenuController

final class MenuTableViewController: UIViewController {

    private struct Constants {
        static let identifier = String(describing: UITableViewCell.self)
        static let topSpacing: CGFloat = 44.0
    }

    private struct Item: Hashable, Sendable {
        let image: UIImage?
        let title: String
        let storyboardID: String
        private let identifier = UUID()

        static func == (lhs: Item, rhs: Item) -> Bool {
            lhs.identifier == rhs.identifier
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        return tableView
    }()

    private var dataSource: UITableViewDiffableDataSource<Int, Item>?

    private let menuItems = [
        Item(image: UIImage.messages(), title: "Home", storyboardID: "root"),
        Item(image: UIImage.home(), title: "Profile", storyboardID: "table"),
        Item(image: UIImage.settings(), title: "Settings", storyboardID: "settings")
    ]
    private var cache = [String: UIViewController]()

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        cacheRootViewController()
        setupView()
        setupDataSource()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.identifier)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topSpacing),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Item>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath)
            var configuration = cell.defaultContentConfiguration()
            configuration.image = item.image
            configuration.text = item.title
            configuration.imageProperties.tintColor = .label
            cell.contentConfiguration = configuration
            return cell
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(menuItems)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    // Cache the view controllers
    private func viewController(with identifier: String) -> UIViewController? {
        if let viewController = cache[identifier] {
            return viewController
        } else if let viewController = storyboard?.instantiateViewController(withIdentifier: identifier) {
            cache[identifier] = viewController
            return viewController
        } else {
            return nil
        }
    }

    // An example to access the currently visible view controller and cache it.
    private func cacheRootViewController() {
        guard let visibleViewController = sideMenuController?.visibleViewController else { return }
        let identifier = menuItems.first?.storyboardID ?? ""
        cache[identifier] = visibleViewController
    }
}

// MARK: - TableView delegate

extension MenuTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = menuItems[indexPath.row]
        guard let viewController = viewController(with: item.storyboardID) else { return }
        sideMenuController?.setViewController(viewController)
    }
}

// MARK: - Extensions

extension UIImage {

    static func messages() -> UIImage? {
        return UIImage(systemName: "text.bubble")?.applyingSymbolConfiguration(.init(scale: .medium))
    }

    static func home() -> UIImage? {
        return UIImage(systemName: "house")?.applyingSymbolConfiguration(.init(scale: .medium))
    }

    static func settings() -> UIImage? {
        return UIImage(systemName: "gearshape")?.applyingSymbolConfiguration(.init(scale: .medium))
    }
}
