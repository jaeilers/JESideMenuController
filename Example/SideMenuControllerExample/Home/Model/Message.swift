//
//  Message.swift
//  SideMenuControllerExample
//
//  Created by JE on 15.07.19.
//  Copyright © 2019 JE. All rights reserved.
//

struct Message: Codable, Sendable {
    let text: String
    let hasImage: Bool?
}
