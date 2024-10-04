//
//  HomeTableViewController.swift
//  SideMenuControllerExample
//
//  Created by Jasmin Eilers on 15.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

import UIKit
import JESideMenuController

final class HomeTableViewController: UIViewController {

    private struct Constants: Sendable {
        static let identifier = String(describing: MessageTableViewCell.self)
    }

    private struct Item: Hashable, Sendable {
        let text: String
        let hasImage: Bool?
        private let identifier = UUID()

        static func == (lhs: Item, rhs: Item) -> Bool {
            lhs.identifier == rhs.identifier
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    // MARK: - Private Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private var dataSource: UITableViewDiffableDataSource<Int, Item>?

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupDataSource()
        try? loadData()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubview(tableView)
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: Constants.identifier)

//        let bbi = UIBarButtonItem(
//            image: UIImage(systemName: "line.3.horizontal"),
//            style: .plain, target: self, action: #selector(toggle(_:))
//        )
//        bbi.tintColor = .label
//        navigationItem.leftBarButtonItem = bbi

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Item>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath)

            if let customCell = cell as? MessageTableViewCell {
                customCell.setText(item.text)
                customCell.showImage(item.hasImage ?? false)
            }

            return cell
        }
    }

    private func loadData() throws {
        let dataLoader = DataLoader()
        let data: [Message] = try dataLoader.loadData()
        let items = data.map { Item(text: $0.text, hasImage: $0.hasImage) }

        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    @objc private func toggle(_ sender: UIBarButtonItem) {
        sideMenuController?.toggle()
    }

}
