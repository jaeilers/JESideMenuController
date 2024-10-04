//
//  DataLoader.swift
//  SideMenuControllerExample
//
//  Created by JE on 15.06.20.
//  Copyright © 2020 JE. All rights reserved.
//

import Foundation

struct DataLoader {

    enum DataLoaderError: Error {
        case fileDoesNotExist
    }

    private let fileName: String
    private let bundle: Bundle

    init(fileName: String = "Messages", bundle: Bundle = .main) {
        self.fileName = fileName
        self.bundle = bundle
    }

    func loadData<T: Decodable>() throws -> T {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw DataLoaderError.fileDoesNotExist
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)

        return decodedData
    }
}
