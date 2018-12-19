//
//  Utils.swift
//  Charging Animation
//
//  Created by Adeyinka Adediji on 18/02/2017.
//  Copyright © 2017 Adeyinka Adediji. All rights reserved.
//

import UIKit

extension UIImageView {
    func tint(color: UIColor) {
        self.image = self.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}

extension UIColor {
    static let BLUE_VIOLET = UIColor("#9F36F8")
    static let DARK_TURQUOISE = UIColor("#15D1DE")
    
    convenience init(_ hex: String) {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 1)))
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        let components = (
            R: CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
            G: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
            B: CGFloat(rgbValue & 0x0000FF) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    convenience init(_ hex: String, alpha: CGFloat) {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 1)))
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        let components = (
            R: CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
            G: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
            B: CGFloat(rgbValue & 0x0000FF) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
}

class Utils {
    func delay(_ delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: closure
        )
    }
}
