//
//  GradientBackgroundView.swift
//  Charging Animation
//
//  Created by Adeyinka Adediji on 01/06/2018.
//  Copyright © 2018 Adeyinka Adediji. All rights reserved.
//

import UIKit

@IBDesignable
class GradientBackgroundView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        updateView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    private func updateView() {
      
        subviews.forEach { $0.removeFromSuperview() }
       
        let colorLayer = CAGradientLayer()
        colorLayer.frame = frame
        colorLayer.colors = [UIColor(hex: Colors.DARK_TURQUOISE).cgColor, UIColor(hex: Colors.BLUE_VIOLET).cgColor]
        colorLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        colorLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        self.layer.addSublayer(colorLayer)
    }
}
