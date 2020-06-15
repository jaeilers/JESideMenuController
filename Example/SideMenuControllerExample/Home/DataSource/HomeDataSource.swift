//
//  HomeDataSource.swift
//  SideMenuControllerExample
//
//  Created by Jasmin Eilers on 15.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource {

    // MARK: - Private Properties

    private let identifier: String
    private weak var tableView: UITableView?
    private var data = [Message]()

    // MARK: - Init

    init(identifier: String, tableView: UITableView? = nil) {
        self.identifier = identifier
        self.tableView = tableView
    }

    // MARK: - DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let customCell = cell as? MessageTableViewCell {
            let item = data[indexPath.row]
            customCell.setText(item.text)
            customCell.showImage(item.hasImage ?? false)
        }

        return cell
    }

    // MARK: - Internal Methods

    func setData(_ data: [Message], animated: Bool = false) {
        self.data = data

        if animated {
            tableView?.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
        } else {
            tableView?.reloadData()
        }
    }

}
