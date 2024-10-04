//
//  MessageConfiguration.swift
//  SideMenuControllerExample
//
//  Created by JE on 04.10.24.
//  Copyright © 2024 JE. All rights reserved.
//

import UIKit

struct MessageConfiguration: UIContentConfiguration, Sendable {

    var text: String
    var hasImage: Bool

    init(text: String = "", hasImage: Bool = false) {
        self.text = text
        self.hasImage = hasImage
    }

    func makeContentView() -> any UIView & UIContentView {
        MessageContentView(configuration: self)
    }

    func updated(for state: any UIConfigurationState) -> MessageConfiguration {
        self
    }
}
