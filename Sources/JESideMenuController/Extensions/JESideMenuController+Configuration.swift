//
//  JESideMenuController+Configuration.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 03.11.19.
//

import UIKit

public extension JESideMenuController {

    /**
     Specify the general configuration of the side menu view controller.
     */
    struct Configuration {
        /// The width of the area that is still visible when the menu is open. Default is 60.
        public let spacing: CGFloat
        /// Specify the width of the menu on iPad. Default is 320.
        public let ipadWidth: CGFloat
        /// A boolean value that specifies if an image is used as drop shadow.
        public let hasDropShadowImage: Bool
        /// Specify the image to use as the drop shadow. Provide a vertical stretching image to use.
        /// Setting this property to `nil` will result in the default drop shadow image.
        public let dropShadowImage: UIImage?

        public init(spacing: CGFloat,
                    ipadWidth: CGFloat,
                    hasDropShadowImage: Bool = true,
                    dropShadowImage: UIImage? = nil) {
            self.spacing = spacing
            self.ipadWidth = ipadWidth
            self.hasDropShadowImage = hasDropShadowImage
            self.dropShadowImage = dropShadowImage
        }

        /// The default configuration provides a visible spacing of 60, an iPad menu width of 320
        /// and a default drop shadow image.
        public static var `default`: Configuration {
            return Configuration(spacing: 60.0, ipadWidth: 320.0)
        }
    }

}
