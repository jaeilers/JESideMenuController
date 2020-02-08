//
//  HomeViewModel.swift
//  SideMenuControllerExample
//
//  Created by Jasmin Eilers on 15.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

import Foundation

struct HomeViewModel {

    // MARK: - Internal Properties

    var setData: ((_ messages: [Message]) -> Void)?

    // MARK: - Private Properties

    private let fileName: String
    private let bundle: Bundle

    // MARK: - Init

    init(fileName: String = "Messages", bundle: Bundle = Bundle.main) {
        self.fileName = fileName
        self.bundle = bundle
    }

    func loadData() {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else { return }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let messages = try decoder.decode([Message].self, from: data)
            setData?(messages)
        } catch {
            print("*** Error: \(error.localizedDescription)")
        }
    }

}
