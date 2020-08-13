//
//  DeviceConfig.swift
//  PreeSwift
//
//  Created by eph132 on 18/08/15.
//  Copyright © 2015 prem. All rights reserved.
//

import Foundation
import UIKit


enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}
struct ConfigUrl
{
    static let urlStr = "http://mobwebapps.com/Baby/"
    static let googleApiKey = "AIzaSyAuFWOPuJQz6MiwGqIXf7H9jvkJ5CYXDRo"
}

extension UIImage
{
    func resizeImage(newWidth: CGFloat) -> UIImage
    {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int)
    {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
extension NSMutableData
{
    func appendString(string: String)
    {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
func isIphoneX() -> Bool
{
    switch UIScreen.main.nativeBounds.height {
    case 1136:
        return false
        
    case 1334:
        return false
        
    case 1920, 2208:
        return false
        
    case 2436:
        return true
        
    case 2688:
        return true
        
    case 1792:
        return true
        
    default:
        return false
        
    }
}
