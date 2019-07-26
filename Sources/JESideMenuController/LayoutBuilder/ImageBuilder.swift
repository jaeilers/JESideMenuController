//
//  ImageBuilder.swift
//  JESideMenuController
//
//  Created by Jasmin Eilers on 09.07.19.
//

import UIKit
import QuartzCore

/**
 The `ImageBuilder` is responsible for rendering images.
 */
struct ImageBuilder {

    /**
     Draws an image of a drop shadow. The image is resizable vertically.
     - isFadingLeft: A Boolean value that determines whether the gradient is fading on the left side or on the right.
    */
    func shadowImage(isFadingLeft: Bool) -> UIImage? {

        let frame = CGRect(x: 0, y: 0, width: 12.0, height: 3.0)
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = frame

        let startAlpha: CGFloat = isFadingLeft ? 0.0 : 0.15
        let endAlpha: CGFloat = isFadingLeft ? 0.15 : 0.0
        gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: startAlpha).cgColor,
                                UIColor(red: 0, green: 0, blue: 0, alpha: endAlpha).cgColor]

        // create and draw the layer in the graphics context to create the image
        var image: UIImage?
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()

        // create a resizable image
        return image?.resizableImage(withCapInsets: UIEdgeInsets(top: 1.0, left: 0.0, bottom: 1.0, right: 0.0),
                                     resizingMode: .stretch)
    }

}
