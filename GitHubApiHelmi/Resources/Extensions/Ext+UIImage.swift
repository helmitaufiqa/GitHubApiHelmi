//
//  Ext+UIImage.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

enum Side: String {
    case top, left, right, bottom
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineThickness: CGFloat, side: Side) -> UIImage {
        var xPosition = 0.0
        var yPosition = 0.0
        var imgWidth = 2.0
        var imgHeight = 2.0
        switch side {
            case .top:
                xPosition = 0.0
                yPosition = 0.0
                imgWidth = Double(size.width)
                imgHeight = Double(lineThickness)
            case .bottom:
                xPosition = 0.0
                yPosition = Double(size.height - lineThickness)
                imgWidth = Double(size.width)
                imgHeight = Double(lineThickness)
            case .left:
                xPosition = 0.0
                yPosition = 0.0
                imgWidth = Double(lineThickness)
                imgHeight = Double(size.height)
            case .right:
                xPosition = Double(size.width - lineThickness)
                yPosition = 0.0
                imgWidth = Double(lineThickness)
                imgHeight = Double(size.height)
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: xPosition, y: yPosition, width: imgWidth, height: imgHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
