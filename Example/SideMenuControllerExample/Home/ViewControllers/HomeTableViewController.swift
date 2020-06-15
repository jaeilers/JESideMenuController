//
//  HomeTableViewController.swift
//  SideMenuControllerExample
//
//  Created by Jasmin Eilers on 15.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

import UIKit
import JESideMenuController

class HomeTableViewController: UIViewController {

    // MARK: - Private Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private lazy var dataSource = HomeDataSource(identifier: String(describing: MessageTableViewCell.self),
                                                 tableView: tableView)

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubview(tableView)

        let bbi = UIBarButtonItem(image: #imageLiteral(resourceName: "toggle"), style: .plain, target: self, action: #selector(toggle(_:)))
        bbi.tintColor = .black
        self.navigationItem.leftBarButtonItem = bbi

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    private func setupTableView() {
        let identifier = String(describing: MessageTableViewCell.self)
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = dataSource

        do {
            let dataLoader = DataLoader()
            let data: [Message] = try dataLoader.loadData()
            dataSource.setData(data)
        } catch {
            print("*** Error: \(error.localizedDescription)")
        }
    }

    @objc private func toggle(_ sender: UIBarButtonItem) {
        sideMenuController?.toggle()
    }

}
