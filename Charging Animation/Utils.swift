//
//  Utils.swift
//  Charging Animation
//
//  Created by Adeyinka Adediji on 18/02/2017.
//  Copyright © 2017 Adeyinka Adediji. All rights reserved.
//

import Foundation
import UIKit


class Utils {
    
    // device screen width
    func getDeviceScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // device screen height
    func getDeviceScreenHeight() -> CGFloat{
        return UIScreen.main.bounds.height
    }
    
    
    // convert  hex color code into iOS UIColor
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    
    // convert  hex color code into translucent iOS UIColor
    func hexStringToUIColorTranslucent (hex:String, alphaValue: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alphaValue
        )
    }
    
    
    // tint  an imageView
    func tintImage (imageView: UIImageView, color: String) {
        imageView.image = imageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.tintColor = hexStringToUIColor(hex: color)
    }
    
    // tint  an imageView with alpha property
    func tintImage (imageView: UIImageView, color: String, alphaValue: CGFloat ) {
        imageView.image = imageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.tintColor = hexStringToUIColorTranslucent(hex: color, alphaValue: alphaValue)
    }
    
    
    //return x-coordinate value where this view ends
    func getViewEndX (viewToMeasure: UIView) -> CGFloat {
        return (viewToMeasure.frame.width + viewToMeasure.frame.origin.x)
    }
    
    //return y-coordinate value where this view ends
    func getViewEndY (viewToMeasure: UIView) -> CGFloat {
        return (viewToMeasure.frame.height + viewToMeasure.frame.origin.y)
    }
    
    // list font family names
    func printFontFamilyNames () {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("Font Family Name ==> \(familyName)")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names ==> \(names)")
        }
    }
    
    // run a block of code after a delay
    func delay(_ delay: Double, closure: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: closure
        )
    }
    
}
