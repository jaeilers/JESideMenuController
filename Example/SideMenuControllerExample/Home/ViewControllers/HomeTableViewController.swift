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

    private var viewModel = HomeViewModel()

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

        let dataSource = HomeDataSource(identifier: identifier,
                                        tableView: tableView)
        viewModel.dataSource = dataSource
        tableView.dataSource = dataSource
        viewModel.loadData()
    }

    @objc private func toggle(_ sender: UIBarButtonItem) {
        sideMenuController?.toggle()
    }

}
