//
//  RingView.swift
//  Charging Animation
//
//  Created by Adeyinka Adediji on 17/12/2018.
//  Copyright © 2018 Adeyinka Adediji. All rights reserved.
//

import UIKit

@IBDesignable
class RingView: UIView {
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
    
    fileprivate func updateView() {
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        }
        
        let width = frame.width
        
        let slideRing = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        slideRing.layer.borderWidth = 2.5
        slideRing.layer.borderColor = UIColor("#ffffff", alpha: 0.3).cgColor
        slideRing.layer.cornerRadius = slideRing.frame.width / 2
        addSubview(slideRing)
        
        let slideRingImageWidth = width - 6
        let slideRingImage = UIImageView(frame: CGRect(x: (width - slideRingImageWidth) / 2, y: (width - slideRingImageWidth) / 2, width: slideRingImageWidth, height: slideRingImageWidth))
        slideRingImage.image = UIImage(named: "ic_chevron_right.png")
        slideRingImage.tint(color: UIColor("#ffffff", alpha: 0.5))
        addSubview(slideRingImage)
    }
}
